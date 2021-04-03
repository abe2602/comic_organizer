import 'dart:io';

import 'package:comix_organizer/generated/l10n.dart';
import 'package:comix_organizer/presentation/collection_list/collection_list_bloc.dart';
import 'package:comix_organizer/presentation/collection_list/collection_list_models.dart';
import 'package:comix_organizer/presentation/common/adaptive_scaffold.dart';
import 'package:comix_organizer/presentation/common/async_snapshot_response_view.dart';
import 'package:comix_organizer/presentation/common/selectable/adaptive_selectable.dart';
import 'package:domain/model/collection.dart';
import 'package:domain/use_case/get_collection_list_uc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class CollectionListPage extends StatelessWidget {
  const CollectionListPage({
    @required this.bloc,
  }) : assert(bloc != null);

  static Widget create() => ProxyProvider2<GetCollectionListUC,
          PublishSubject<void>, CollectionListBloc>(
        update: (
          _,
          getCollectionListUC,
          collectionListDataObservable,
          currentBloc,
        ) =>
            currentBloc ??
            CollectionListBloc(
              getCollectionListUC: getCollectionListUC,
              collectionListDataObservable: collectionListDataObservable,
            ),
        child: Consumer<CollectionListBloc>(
          builder: (_, bloc, __) => CollectionListPage(
            bloc: bloc,
          ),
        ),
      );

  final CollectionListBloc bloc;

  @override
  Widget build(BuildContext context) => AdaptiveScaffold(
        title: S.of(context).comicCollectionTitle,
        scaffoldAction: () async {
          final isSuccess = await Navigator.of(context, rootNavigator: true)
              .pushNamed('/newCollection');

          if (isSuccess != null && isSuccess) {
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(S.of(context).addedWithSuccessTitle),
                content: Text(S.of(context).addedWithSuccessText),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(S.of(context).addedWithSuccessButtonText),
                  ),
                ],
              ),
            );
          }
        },
        body: StreamBuilder(
          stream: bloc.onNewState,
          builder: (context, snapshot) =>
              AsyncSnapshotResponseView<Loading, Error, Success>(
            snapshot: snapshot,
            successWidgetBuilder: (success) => GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: success.collectionList.length,
              itemBuilder: (_, index) => _CollectionCard(
                collection: success.collectionList[index],
              ),
            ),
            errorWidgetBuilder: (error) => Text('Erro'),
          ),
        ),
      );
}

class _CollectionCard extends StatelessWidget {
  const _CollectionCard({
    @required this.collection,
  }) : assert(collection != null);

  final Collection collection;

  @override
  Widget build(BuildContext context) => Card(
        elevation: 2,
        child: AdaptiveSelectable(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/collection/${collection.collectionName}',
            );
          },
          child: Column(
            children: [
              if (collection.imagePath != null)
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Image.file(
                    File(collection.imagePath),
                  ),
                )
              else
                Container(),
              Text(collection.collectionName),
            ],
          ),
        ),
      );
}

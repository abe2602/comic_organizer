import 'package:comix_organizer/presentation/collection_list/collection_list_bloc.dart';
import 'package:comix_organizer/presentation/collection_list/collection_list_models.dart';
import 'package:comix_organizer/presentation/common/adaptive_scaffold.dart';
import 'package:comix_organizer/presentation/common/async_snapshot_response_view.dart';
import 'package:comix_organizer/presentation/common/selectable/adaptive_selectable.dart';
import 'package:domain/use_case/get_collection_list_uc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionListPage extends StatelessWidget {
  const CollectionListPage({
    @required this.bloc,
  }) : assert(bloc != null);

  static Widget create() =>
      ProxyProvider<GetCollectionListUC, CollectionListBloc>(
        update: (_, getCollectionListUC, currentBloc) =>
            currentBloc ??
            CollectionListBloc(
              getCollectionListUC: getCollectionListUC,
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
        title: 'My Collection',
        onPressed: () => Navigator.of(context, rootNavigator: true)
            .pushNamed('/newCollection'),
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
              itemBuilder: (_, index) => AdaptiveSelectable(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/collection/2',
                  );
                },
                child: Text(success.collectionList[index].collectionName),
              ),
            ),
            errorWidgetBuilder: (error) => Text('Erro'),
          ),
        ),
      );
}

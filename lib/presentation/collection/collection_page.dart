import 'package:comix_organizer/presentation/collection/collection_bloc.dart';
import 'package:comix_organizer/presentation/common/adaptive_scaffold.dart';
import 'package:comix_organizer/presentation/common/async_snapshot_response_view.dart';
import 'package:comix_organizer/presentation/common/selectable/adaptive_selectable.dart';
import 'package:domain/use_case/get_books_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'collection_models.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({
    @required this.collectionId,
    @required this.bloc,
  })
      : assert(collectionId != null),
        assert(bloc != null);

  static Widget create(String collectionId) =>
      ProxyProvider<GetBooksListUC, CollectionBloc>(
        update: (_, getBooksListUC, bloc) =>
        bloc ??
            CollectionBloc(
              getBooksListUC: getBooksListUC,
            ),
        child: Consumer<CollectionBloc>(
          builder: (_, bloc, __) =>
              CollectionPage(
                bloc: bloc,
                collectionId: collectionId,
              ),
        ),
      );

  final CollectionBloc bloc;
  final String collectionId;

  @override
  Widget build(BuildContext context) => AdaptiveScaffold(
      title: 'NAME',
      body: StreamBuilder(
        stream: bloc.onNewState,
        builder: (context, snapshot) =>
            AsyncSnapshotResponseView<Loading, Error, Success>(
              snapshot: snapshot,
              successWidgetBuilder: (success) =>
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ((MediaQuery
                          .of(context)
                          .size
                          .width) ~/ 100).toInt(),
                    ),
                    itemCount: success.bookList.length,
                    itemBuilder: (_, index) =>
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: 220,
                          width: double.maxFinite,
                          child: Card(
                            elevation: 5,
                            child: AdaptiveSelectable(
                              onTap: () {},
                              child: Center(
                                child: Text(
                                  index.toString(),
                                ),
                              ),
                            ),
                          ),
                        ),
                  ),
              errorWidgetBuilder: (error) => Text('Erro'),
            ),
      ),
    );
}

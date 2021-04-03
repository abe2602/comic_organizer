import 'dart:async';

import 'package:comix_organizer/presentation/collection/collection_bloc.dart';
import 'package:comix_organizer/presentation/common/adaptive_filled_button.dart';
import 'package:comix_organizer/presentation/common/adaptive_scaffold.dart';
import 'package:comix_organizer/presentation/common/async_snapshot_response_view.dart';
import 'package:comix_organizer/presentation/common/selectable/adaptive_selectable.dart';
import 'package:domain/use_case/add_book_list.dart';
import 'package:domain/use_case/get_books_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'collection_models.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({
    @required this.collectionName,
    @required this.bloc,
  })  : assert(collectionName != null),
        assert(bloc != null);

  static Widget create(String collectionName) =>
      ProxyProvider2<GetBooksListUC, AddBookListUC, CollectionBloc>(
        update: (_, getBooksListUC, addBookListUC, bloc) =>
            bloc ??
            CollectionBloc(
              getBooksListUC: getBooksListUC,
              collectionName: collectionName,
              addBookListUC: addBookListUC,
            ),
        child: Consumer<CollectionBloc>(
          builder: (_, bloc, __) => CollectionPage(
            bloc: bloc,
            collectionName: collectionName,
          ),
        ),
      );

  final CollectionBloc bloc;
  final String collectionName;

  @override
  State<StatefulWidget> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          widget.bloc.updateBookListSink.add(null);
          return true;
        },
        child: AdaptiveScaffold(
          title: widget.collectionName,
          body: StreamBuilder(
            stream: widget.bloc.onNewState,
            builder: (context, snapshot) =>
                AsyncSnapshotResponseView<Loading, Error, Success>(
              snapshot: snapshot,
              successWidgetBuilder: (success) => Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            ((MediaQuery.of(context).size.width) ~/ 100)
                                .toInt(),
                      ),
                      itemCount: success.bookList.length,
                      itemBuilder: (_, index) => Container(
                        padding: const EdgeInsets.all(10),
                        height: 220,
                        width: double.maxFinite,
                        child: Card(
                          elevation: 5,
                          child: AdaptiveSelectable(
                            onTap: () {
                              widget.bloc.changeBookStatusSink.add(index);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              color: success.bookList[index].color,
                              child: Text(
                                (index + 1).toString(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    elevation: 5,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AdaptiveFilledButton(
                                child: Text('-'),
                                onPressed: () {
                                  widget.bloc.removeBookSink.add(null);
                                  Timer(
                                    const Duration(milliseconds: 100),
                                    () => _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                      curve: Curves.easeOut,
                                      duration:
                                          const Duration(milliseconds: 300),
                                    ),
                                  );
                                }),
                            AdaptiveFilledButton(
                              child: Text('+'),
                              onPressed: () async {
                                widget.bloc.addBookSink.add(null);

                                Timer(
                                  const Duration(milliseconds: 100),
                                  () => _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    curve: Curves.easeOut,
                                    duration: const Duration(milliseconds: 300),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              errorWidgetBuilder: (error) => Text('Erro'),
            ),
          ),
        ),
      );
}

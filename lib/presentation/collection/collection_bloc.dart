import 'package:comix_organizer/presentation/collection/collection_models.dart';
import 'package:comix_organizer/presentation/common/subscription_utils.dart';
import 'package:domain/model/book.dart';
import 'package:domain/use_case/add_book_list.dart';
import 'package:domain/use_case/get_books_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'collection_mappers.dart';

class CollectionBloc with SubscriptionBag {
  CollectionBloc({
    @required this.getBooksListUC,
    @required this.collectionName,
    @required this.addBookListUC,
  })  : assert(getBooksListUC != null),
        assert(collectionName != null),
        assert(addBookListUC != null) {
    MergeStream(
      [
        _getCollectionList(),
        _changeBookStatusSubject.flatMap(
          (_) => _changeBookStatus(),
        ),
        _addBookSubject.flatMap(
          (_) => _addBook(),
        ),
        _removeBookSubject.flatMap(
          (_) => _removeBook(),
        ),
      ],
    ).listen(_onNewStateSubject.add).addTo(subscriptionsBag);

    _updateBookListSubject
        .flatMap((value) => _updateBookList())
        .listen((event) {})
        .addTo(subscriptionsBag);
  }

  final GetBooksListUC getBooksListUC;
  final AddBookListUC addBookListUC;
  final String collectionName;
  final _onNewStateSubject = BehaviorSubject<CollectionResponseState>();
  final List<BookVM> _bookList = [];

  Stream<CollectionResponseState> get onNewState => _onNewStateSubject;

  // Add book
  final PublishSubject<void> _addBookSubject = PublishSubject();

  Sink<void> get addBookSink => _addBookSubject.sink;

  // Remove book
  final PublishSubject<void> _removeBookSubject = PublishSubject();

  Sink<void> get removeBookSink => _removeBookSubject.sink;

  // Update BookList
  final PublishSubject<void> _updateBookListSubject = PublishSubject();

  Sink<void> get updateBookListSink => _updateBookListSubject.sink;

  // Change Status
  final BehaviorSubject<int> _changeBookStatusSubject = BehaviorSubject();

  Sink<int> get changeBookStatusSink => _changeBookStatusSubject.sink;

  // Function
  Stream<CollectionResponseState> _getCollectionList() async* {
    yield Loading();

    try {
      final bookList = await getBooksListUC.getFuture(
        params: GetBooksListParamsUC(id: collectionName),
      );

      _bookList.addAll(
        bookList
            .map(
              (book) => book.toVM(),
            )
            .toList(),
      );

      yield Success(
        bookList: _bookList,
      );
    } catch (error) {
      print(error.toString());
    }
  }

  Stream<CollectionResponseState> _changeBookStatus() async* {
    try {
      final newList = <BookVM>[];

      _bookList.asMap().forEach(
        (index, book) {
          if (index == _changeBookStatusSubject.value) {
            BookVM newBook;
            if (book.status == BookStatusVM.owned) {
              newBook = const BookVM(
                  status: BookStatusVM.notOwned, color: Colors.red);
            } else {
              newBook =
                  const BookVM(status: BookStatusVM.owned, color: Colors.blue);
            }
            newList.add(newBook);
          } else {
            newList.add(book);
          }
        },
      );

      _bookList
        ..clear()
        ..addAll(newList);

      yield Success(
        bookList: _bookList,
      );
    } catch (error) {
      print(error.toString());
    }
  }

  Stream<CollectionResponseState> _addBook() async* {
    try {
      _bookList.add(
        const BookVM(status: BookStatusVM.notOwned, color: Colors.red),
      );

      yield Success(
        bookList: _bookList,
      );
    } catch (error) {
      print(error.toString());
    }
  }

  Stream<CollectionResponseState> _removeBook() async* {
    if (_bookList.length > 1) {
      try {
        _bookList.removeLast();

        yield Success(
          bookList: _bookList,
        );
      } catch (error) {
        print(error.toString());
      }
    }
  }

  Stream<void> _updateBookList() async* {
    try {
      await addBookListUC.getFuture(
        params: AddBookListParamsUC(
          collectionName: collectionName,
          bookList: _bookList
              .map(
                (bookVM) => Book(
                  status: bookVM.status.toDM(),
                ),
              )
              .toList(),
        ),
      );
    } catch (error) {}
  }

  void dispose() {
    _addBookSubject.close();
    _removeBookSubject.close();
    _onNewStateSubject.close();
    _changeBookStatusSubject.close();
    _updateBookListSubject.close();
  }
}

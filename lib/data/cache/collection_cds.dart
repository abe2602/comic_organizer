import 'package:comix_organizer/data/cache/models/book_cm.dart';
import 'package:comix_organizer/data/cache/models/collection_cm.dart';
import 'package:domain/exceptions.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class CollectionCDS {
  CollectionCDS({
    @required this.collectionListDataObservableSink,
  }) : assert(collectionListDataObservableSink != null);
  static const _collectionListBoxKey = '_collectionListBoxKey';
  static const _bookListBoxKey = '_bookListBoxKey';

  final Sink<void> collectionListDataObservableSink;

  Future<Box> _openCollectionListBox() => Hive.openBox(_collectionListBoxKey);

  Future<Box> _openBookListBox() => Hive.openBox(_bookListBoxKey);

  Future<List<CollectionCM>> getCollectionList() =>
      _openCollectionListBox().then(
        (box) {
          final List<CollectionCM> collectionList =
              box.get(_collectionListBoxKey)?.cast<CollectionCM>();

          if (collectionList == null || collectionList.isEmpty) {
            throw EmptyCachedListException();
          } else {
            return collectionList;
          }
        },
      );

  Future<List<BookCM>> getBookList(String id) => _openBookListBox().then(
        (box) {
          final List<BookCM> bookList = box.get(id)?.cast<BookCM>();

          if (bookList == null || bookList.isEmpty) {
            throw EmptyCachedListException();
          } else {
            return bookList;
          }
        },
      );

  Future<void> addCollection(String collectionName, String imagePath) =>
      _openCollectionListBox().then(
        (box) {
          final List<CollectionCM> collectionList =
              box.get(_collectionListBoxKey)?.cast<CollectionCM>() ?? [];

          if (collectionList
              .map((collection) => collection.name == collectionName)
              .toList()
              .contains(true)) {
            // already added this collection
            throw CollectionAlreadyAddedException();
          } else {
            collectionListDataObservableSink.add(null);

            collectionList
                .add(CollectionCM(name: collectionName, imageUrl: imagePath));

            return box.put(_collectionListBoxKey, collectionList);
          }
        },
      );

  Future<void> addBookList(String collectionName, List<BookCM> bookList) =>
      _openBookListBox().then(
        (box) => box.put(collectionName, bookList),
      );
}

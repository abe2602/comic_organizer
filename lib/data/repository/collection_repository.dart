import 'package:comix_organizer/data/cache/collection_cds.dart';
import 'package:comix_organizer/data/cache/models/book_cm.dart';
import 'package:comix_organizer/data/mappers/cache_to_domain_mapper.dart';
import 'package:comix_organizer/data/mappers/domain_to_cache_mapper.dart';
import 'package:domain/data_repository/collection_data_repository.dart';
import 'package:domain/model/book.dart';
import 'package:domain/model/collection.dart';
import 'package:flutter/foundation.dart';

class CollectionRepository implements CollectionDataRepository {
  const CollectionRepository({
    @required this.collectionCDS,
  }) : assert(collectionCDS != null);

  final CollectionCDS collectionCDS;

  @override
  Future<List<Collection>> getCollectionList() =>
      collectionCDS.getCollectionList().then(
            (collectionList) => collectionList
                .map(
                  (collectionCM) => collectionCM.toDM(),
                )
                .toList(),
          );

  @override
  Future<List<Book>> getBooksList(String id) =>
      collectionCDS.getBookList(id).then(
            (bookListCM) => bookListCM.toDM(),
          );

  @override
  Future<void> addCollection(
          String collectionName, int collectionSize, String imagePath) =>
      collectionCDS
          .addCollection(collectionName, imagePath)
          .then(
            (_) => collectionCDS.addBookList(
              collectionName,
              List.filled(
                collectionSize,
                const BookCM(status: 0),
              ),
            ),
          )
          .catchError(
        (error) {
          print(error.toString());
          throw error;
        },
      );

  @override
  Future<void> addBookList(String id, List<Book> bookList) =>
      collectionCDS.addBookList(
        id,
        bookList.toCM(),
      );
}

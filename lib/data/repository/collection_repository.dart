import 'package:comix_organizer/data/cache/collection_cds.dart';
import 'package:domain/data_repository/collection_data_repository.dart';
import 'package:domain/model/book.dart';
import 'package:domain/model/book_status.dart';
import 'package:domain/model/collection.dart';
import 'package:flutter/foundation.dart';

class CollectionRepository implements CollectionDataRepository {
  const CollectionRepository({
    @required this.collectionCDS,
  }) : assert(collectionCDS != null);

  final CollectionCDS collectionCDS;

  @override
  Future<List<Collection>> getCollectionList() => Future.value(
        const [
          Collection(collectionName: 'Naruto'),
          Collection(collectionName: 'Naruto'),
          Collection(collectionName: 'Naruto'),
          Collection(collectionName: 'Naruto'),
          Collection(collectionName: 'Naruto'),
        ],
      );

  @override
  Future<List<Book>> getBooksList(int id) => Future.value(
    const [
      Book(status: BookStatus.owned),
      Book(status: BookStatus.owned),
      Book(status: BookStatus.owned),
      Book(status: BookStatus.owned),
      Book(status: BookStatus.owned),
      Book(status: BookStatus.owned),
    ],
  );
}

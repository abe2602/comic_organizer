import 'package:domain/model/book.dart';
import 'package:domain/model/collection.dart';

abstract class CollectionDataRepository {
  Future<List<Collection>> getCollectionList();

  Future<List<Book>> getBooksList(int id);
}

import 'package:domain/model/book.dart';
import 'package:domain/model/collection.dart';

abstract class CollectionDataRepository {
  Future<List<Collection>> getCollectionList();

  Future<List<Book>> getBooksList(String id);

  Future<void> addCollection(
      String collectionName, int collectionSize, String imagePath);

  Future<void> deleteCollection(String collectionName);

  Future<void> addBookList(String id, List<Book> bookList);

}

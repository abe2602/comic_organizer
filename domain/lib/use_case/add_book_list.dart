import 'package:domain/data_repository/collection_data_repository.dart';
import 'package:domain/model/book.dart';
import 'package:domain/use_case/use_case.dart';
import 'package:flutter/foundation.dart';

class AddBookListUC extends UseCase<AddBookListParamsUC, void> {
  AddBookListUC({
    @required this.collectionRepository,
  }) : assert(collectionRepository != null);

  final CollectionDataRepository collectionRepository;

  @override
  Future<void> getRawFuture({AddBookListParamsUC params}) =>
      collectionRepository.addBookList(
        params.collectionName,
        params.bookList,
      );
}

class AddBookListParamsUC {
  const AddBookListParamsUC({
    @required this.collectionName,
    @required this.bookList,
  })  : assert(collectionName != null),
        assert(bookList != null);

  final String collectionName;
  final List<Book> bookList;
}

import 'package:domain/data_repository/collection_data_repository.dart';
import 'package:domain/model/book.dart';
import 'package:domain/use_case/use_case.dart';
import 'package:flutter/material.dart';

class GetBooksListUC extends UseCase<GetBooksListParamsUC, List<Book>> {
  GetBooksListUC({
    @required this.collectionRepository,
  }) : assert(collectionRepository != null);

  final CollectionDataRepository collectionRepository;

  @override
  Future<List<Book>> getRawFuture({GetBooksListParamsUC params}) =>
      collectionRepository.getBooksList(params.id);
}

class GetBooksListParamsUC {
  const GetBooksListParamsUC({
    @required this.id,
  }) : assert(id != null);

  final String id;
}

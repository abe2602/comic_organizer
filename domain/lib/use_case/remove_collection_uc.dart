import 'package:domain/data_repository/collection_data_repository.dart';
import 'package:domain/use_case/use_case.dart';
import 'package:flutter/foundation.dart';

class DeleteCollectionUC extends UseCase<DeleteCollectionParamsUC, void> {
  DeleteCollectionUC({
    @required this.collectionRepository,
  }) : assert(collectionRepository != null);

  final CollectionDataRepository collectionRepository;

  @override
  Future<void> getRawFuture({DeleteCollectionParamsUC params}) =>
      collectionRepository.deleteCollection(
        params.collectionName,
      );
}

class DeleteCollectionParamsUC {
  const DeleteCollectionParamsUC({
    @required this.collectionName,
  })  : assert(collectionName != null);

  final String collectionName;
}

import 'package:domain/data_repository/collection_data_repository.dart';
import 'package:domain/use_case/use_case.dart';
import 'package:flutter/foundation.dart';

class AddCollectionUC extends UseCase<AddCollectionParamsUC, void> {
  AddCollectionUC({
    @required this.collectionRepository,
  }) : assert(collectionRepository != null);

  final CollectionDataRepository collectionRepository;

  @override
  Future<void> getRawFuture({AddCollectionParamsUC params}) =>
      collectionRepository.addCollection(
        params.collectionName,
        params.collectionSize,
        params.imagePath,
      );
}

class AddCollectionParamsUC {
  const AddCollectionParamsUC({
    @required this.collectionName,
    @required this.collectionSize,
    this.imagePath,
  })  : assert(collectionName != null),
        assert(collectionSize != null);

  final String collectionName;
  final int collectionSize;
  final String imagePath;
}

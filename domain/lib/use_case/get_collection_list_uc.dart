import 'package:domain/data_repository/collection_data_repository.dart';
import 'package:domain/model/collection.dart';
import 'package:meta/meta.dart';

import 'use_case.dart';

class GetCollectionListUC extends UseCase<void, List<Collection>> {
  GetCollectionListUC({
    @required this.collectionRepository,
  }) : assert(collectionRepository != null);

  final CollectionDataRepository collectionRepository;

  @override
  Future<List<Collection>> getRawFuture({void params}) =>
      collectionRepository.getCollectionList();
}
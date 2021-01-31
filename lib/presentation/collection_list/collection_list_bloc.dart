import 'package:comix_organizer/presentation/collection_list/collection_list_models.dart';
import 'package:comix_organizer/presentation/common/subscription_utils.dart';
import 'package:domain/use_case/get_collection_list_uc.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class CollectionListBloc with SubscriptionBag {
  CollectionListBloc({
    @required this.getCollectionListUC,
  }) : assert(getCollectionListUC != null) {
    MergeStream(
      [
        _getCollectionList(),
      ],
    ).listen(_onNewStateSubject.add).addTo(subscriptionsBag);
  }

  final GetCollectionListUC getCollectionListUC;

  final _onNewStateSubject = BehaviorSubject<CollectionListResponseState>();

  Stream<CollectionListResponseState> get onNewState => _onNewStateSubject;

  Stream<CollectionListResponseState> _getCollectionList() async* {
    try {
      final collectionList = await getCollectionListUC.getFuture();
      yield Success(
        collectionList: collectionList,
      );
    } catch (error) {}
  }

  void dispose() {
    _onNewStateSubject.close();
  }
}

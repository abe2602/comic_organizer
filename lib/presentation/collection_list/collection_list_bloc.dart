import 'package:comix_organizer/presentation/collection_list/collection_list_models.dart';
import 'package:comix_organizer/presentation/common/subscription_utils.dart';
import 'package:domain/exceptions.dart';
import 'package:domain/use_case/get_collection_list_uc.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class CollectionListBloc with SubscriptionBag {
  CollectionListBloc({
    @required this.getCollectionListUC,
    @required this.collectionListDataObservable,
  })  : assert(getCollectionListUC != null),
        assert(collectionListDataObservable != null) {
    MergeStream(
      [
        collectionListDataObservable.flatMap(
          (_) => _getCollectionList(),
        ),
        _getCollectionList(),
      ],
    ).listen(_onNewStateSubject.add).addTo(subscriptionsBag);
  }

  final GetCollectionListUC getCollectionListUC;

  final PublishSubject<void> collectionListDataObservable;

  final _onNewStateSubject = BehaviorSubject<CollectionListResponseState>();

  Stream<CollectionListResponseState> get onNewState => _onNewStateSubject;

  Stream<CollectionListResponseState> _getCollectionList() async* {
    try {
      final collectionList = await getCollectionListUC.getFuture();
      yield Success(
        collectionList: collectionList,
      );
    } catch (error) {
      if (error is EmptyCachedListException) {
        yield const Success(
          collectionList: [],
        );
      } else {
        yield Error();
      }
    }
  }

  void dispose() {
    _onNewStateSubject.close();
    collectionListDataObservable.close();
  }
}

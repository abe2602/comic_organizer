import 'package:comix_organizer/presentation/collection_list/collection_list_models.dart';
import 'package:comix_organizer/presentation/common/subscription_utils.dart';
import 'package:domain/exceptions.dart';
import 'package:domain/use_case/get_collection_list_uc.dart';
import 'package:domain/use_case/remove_collection_uc.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class CollectionListBloc with SubscriptionBag {
  CollectionListBloc({
    @required this.getCollectionListUC,
    @required this.deleteCollectionUC,
    @required this.collectionListDataObservable,
  })  : assert(getCollectionListUC != null),
        assert(deleteCollectionUC != null),
        assert(collectionListDataObservable != null) {
    MergeStream(
      [
        collectionListDataObservable.flatMap(
          (_) => _getCollectionList(),
        ),
        _getCollectionList(),
      ],
    ).listen(_onNewStateSubject.add).addTo(subscriptionsBag);

    _deleteCollectionSubject
        .flatMap(deleteCollection)
        .listen((value) {})
        .addTo(subscriptionsBag);
  }

  final GetCollectionListUC getCollectionListUC;

  final DeleteCollectionUC deleteCollectionUC;

  final PublishSubject<void> collectionListDataObservable;

  // New state
  final _onNewStateSubject = BehaviorSubject<CollectionListResponseState>();

  Stream<CollectionListResponseState> get onNewState => _onNewStateSubject;

  // Delete
  final PublishSubject<String> _deleteCollectionSubject = PublishSubject();

  Sink<String> get deleteCollectionSink => _deleteCollectionSubject.sink;

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

  Stream<void> deleteCollection(String collectionName) async* {
    try {
      await deleteCollectionUC.getFuture(
          params: DeleteCollectionParamsUC(collectionName: collectionName));
    } catch (error) {
      // Adicionar dialog de erro ao retirar
    }
  }

  void dispose() {
    _onNewStateSubject.close();
    _deleteCollectionSubject.close();
    collectionListDataObservable.close();
  }
}

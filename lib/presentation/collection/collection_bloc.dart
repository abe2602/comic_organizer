import 'package:comix_organizer/presentation/collection/collection_models.dart';
import 'package:comix_organizer/presentation/common/subscription_utils.dart';
import 'package:domain/use_case/get_books_list.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class CollectionBloc with SubscriptionBag {
  CollectionBloc({
    @required this.getBooksListUC,
  }) : assert(getBooksListUC != null) {
    MergeStream(
      [
        _getCollectionList(),
      ],
    ).listen(_onNewStateSubject.add).addTo(subscriptionsBag);
  }

  final GetBooksListUC getBooksListUC;

  final _onNewStateSubject = BehaviorSubject<CollectionResponseState>();

  Stream<CollectionResponseState> get onNewState => _onNewStateSubject;

  Stream<CollectionResponseState> _getCollectionList() async* {
    yield Loading();

    try {
      final bookList = await getBooksListUC.getFuture(
        params: GetBooksListParamsUC(id: 1),
      );
      yield Success(
        bookList: bookList,
      );
    } catch (error) {
      print(error.toString());
    }
  }

  void dispose() {
    _onNewStateSubject.close();
  }
}

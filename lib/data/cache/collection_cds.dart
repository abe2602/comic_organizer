import 'package:flutter/widgets.dart';

class CollectionCDS {
  CollectionCDS({
    @required this.collectionListDataObservableSink,
  }) : assert(collectionListDataObservableSink != null);
  static const _collectionListBoxKey = '_collectionListBoxKey';

  final Sink<void> collectionListDataObservableSink;
}

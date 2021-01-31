import 'package:flutter/cupertino.dart';

class Collection {
  const Collection({
    @required this.collectionName,
  }) : assert(collectionName != null);

  final String collectionName;
}

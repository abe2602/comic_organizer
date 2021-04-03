import 'package:flutter/cupertino.dart';

class Collection {
  const Collection({
    @required this.collectionName,
    this.imagePath,
  }) : assert(collectionName != null);

  final String collectionName;
  final String imagePath;
}

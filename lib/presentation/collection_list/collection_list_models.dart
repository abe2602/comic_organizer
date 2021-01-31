import 'package:domain/model/collection.dart';
import 'package:flutter/material.dart';

abstract class CollectionListResponseState {}

class Success implements CollectionListResponseState {
  const Success({
    @required this.collectionList,
  }) : assert(collectionList != null);

  final List<Collection> collectionList;
}

class Loading implements CollectionListResponseState {}

class Error implements CollectionListResponseState {}
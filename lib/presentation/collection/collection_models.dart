import 'package:domain/model/book.dart';
import 'package:flutter/material.dart';

abstract class CollectionResponseState {}

class Success implements CollectionResponseState {
  const Success({
    @required this.bookList,
  }) : assert(bookList != null);

  final List<Book> bookList;
}

class Loading implements CollectionResponseState {}

class Error implements CollectionResponseState {}

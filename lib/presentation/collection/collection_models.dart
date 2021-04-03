import 'package:domain/model/book.dart';
import 'package:flutter/material.dart';

abstract class CollectionResponseState {}

class Success implements CollectionResponseState {
  const Success({
    @required this.bookList,
  }) : assert(bookList != null);

  final List<BookVM> bookList;
}

class Loading implements CollectionResponseState {}

class Error implements CollectionResponseState {}

class BookVM {
  const BookVM({
    @required this.status,
    @required this.color,
  }) : assert(status != null), assert(color != null);

  final BookStatusVM status;
  final Color color;
}

enum BookStatusVM {
  owned, notOwned
}

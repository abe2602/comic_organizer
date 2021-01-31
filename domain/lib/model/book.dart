import 'package:domain/model/book_status.dart';
import 'package:flutter/cupertino.dart';

class Book {
  const Book({
    @required this.status,
  }) : assert(status != null);

  final BookStatus status;
}

import 'package:comix_organizer/presentation/collection/collection_models.dart';
import 'package:domain/model/book.dart';
import 'package:domain/model/book_status.dart';
import 'package:flutter/material.dart';

extension BookStatusVMToDM on BookStatusVM {
  BookStatus toDM() {
    if (this == BookStatusVM.notOwned) {
      return BookStatus.notOwned;
    } else {
      return BookStatus.owned;
    }
  }
}

extension BookStatusDMToVM on BookStatus {
  BookStatusVM toVM() {
    if (this == BookStatus.notOwned) {
      return BookStatusVM.notOwned;
    } else {
      return BookStatusVM.owned;
    }
  }
}

extension BookDMToVM on Book {
  BookVM toVM() => BookVM(
        status: status.toVM(),
        color: status == BookStatus.owned ? Colors.blue : Colors.red,
      );
}

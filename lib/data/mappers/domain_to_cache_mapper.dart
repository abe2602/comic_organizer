import 'package:comix_organizer/data/cache/models/book_cm.dart';
import 'package:domain/model/book.dart';
import 'package:domain/model/book_status.dart';

extension BookListDMToCM on List<Book> {
  List<BookCM> toCM() => map(
        (book) => book.toCM(),
  ).toList();
}

extension BookDMToCM on Book {
  BookCM toCM() => BookCM(
    status: status.toInt(),
  );
}

extension IntToBookStatus on BookStatus {
  int toInt() {
    if (this == BookStatus.notOwned) {
      return 0;
    } else {
      return 1;
    }
  }
}

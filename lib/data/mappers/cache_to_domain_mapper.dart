import 'package:comix_organizer/data/cache/models/book_cm.dart';
import 'package:comix_organizer/data/cache/models/collection_cm.dart';
import 'package:domain/model/book.dart';
import 'package:domain/model/book_status.dart';
import 'package:domain/model/collection.dart';

extension CollectionCMToDM on CollectionCM {
  Collection toDM() => Collection(
        collectionName: name,
        imagePath: imageUrl,
      );
}

extension BookListCMToDM on List<BookCM> {
  List<Book> toDM() => map(
        (bookCM) => bookCM.toDM(),
      ).toList();
}

extension BookCMToDM on BookCM {
  Book toDM() => Book(
        status: status.toBookStatus(),
      );
}

extension IntToBookStatus on int {
  BookStatus toBookStatus() {
    if (this == 0) {
      return BookStatus.notOwned;
    } else {
      return BookStatus.owned;
    }
  }
}

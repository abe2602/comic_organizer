import 'package:domain/model/book_status.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'book_cm.g.dart';

@HiveType(typeId: 1)
class BookCM {
  const BookCM({
    @required this.status,
  })  : assert(status != null);

  @HiveField(0)
  final BookStatus status;
}

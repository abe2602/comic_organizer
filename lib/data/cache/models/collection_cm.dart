import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'collection_cm.g.dart';

@HiveType(typeId: 0)
class CollectionCM {
  const CollectionCM({
    @required this.name,
    this.imageUrl,
  })  : assert(name != null);

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String imageUrl;
}

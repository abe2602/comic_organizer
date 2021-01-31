import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'collection_cm.g.dart';

@HiveType(typeId: 0)
class CollectionCM {
  const CollectionCM({
    @required this.name,
    @required this.imageUrl,
  })  : assert(name != null),
        assert(imageUrl != null);

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String imageUrl;
}

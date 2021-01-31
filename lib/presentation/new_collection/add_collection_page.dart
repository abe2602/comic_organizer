import 'package:comix_organizer/presentation/common/adaptive_scaffold.dart';
import 'package:flutter/cupertino.dart';

class AddCollectionPage extends StatelessWidget {
  static Widget create() => AddCollectionPage();

  @override
  Widget build(BuildContext context) => AdaptiveScaffold(
        title: 'Add a new Collection',
        body: Text('Create'),
      );
}

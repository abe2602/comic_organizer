import 'package:comix_organizer/presentation/common/adaptive_loading_indicator.dart';
import 'package:flutter/widgets.dart';

class AsyncSnapshotResponseView<Loading, Error, Success>
    extends StatelessWidget {
  AsyncSnapshotResponseView(
      {@required this.snapshot,
      @required this.successWidgetBuilder,
      @required this.errorWidgetBuilder})
      : assert(snapshot != null),
        assert(successWidgetBuilder != null),
        assert(Loading != null),
        assert(Error != null),
        assert(Success != null);

  final AsyncSnapshot snapshot;
  final Widget Function(Success success) successWidgetBuilder;
  final Widget Function(Error error) errorWidgetBuilder;

  @override
  Widget build(BuildContext context) {
    final snapshotData = snapshot.data;

    if (snapshotData == null || snapshotData is Loading) {
      return AdaptiveLoadingIndicator();
    } else if (snapshotData is Error) {
      return errorWidgetBuilder(snapshotData);
    } else if (snapshotData is Success) {
      return successWidgetBuilder(snapshotData);
    }

    throw UnknownStateTypeException();
  }
}

class UnknownStateTypeException implements Exception {}

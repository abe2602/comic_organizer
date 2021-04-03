import 'package:comix_organizer/presentation/common/subscription_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ActionHandler<T> extends StatefulWidget {
  const ActionHandler({
    @required this.child,
    @required this.actionStream,
    @required this.onReceived,
    Key key,
  })  : assert(child != null),
        assert(actionStream != null),
        assert(onReceived != null),
        super(key: key);

  final Widget child;
  final Stream<T> actionStream;
  final ValueChanged<T> onReceived;

  @override
  _ActionHandlerState<T> createState() => _ActionHandlerState<T>();
}

class _ActionHandlerState<T> extends State<ActionHandler<T>>
    with SubscriptionBag {
  @override
  void initState() {
    super.initState();
    widget.actionStream
        .listen(
          widget.onReceived,
        )
        .addTo(subscriptionsBag);
  }

  @override
  void dispose() {
    super.dispose();
    disposeAll();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

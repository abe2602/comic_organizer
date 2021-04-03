import 'dart:io';

import 'package:flutter/material.dart';
import 'cupertino_selectable.dart';

/// Makes the child widget selectable and gives it the visual feedback of
/// the selection.
class AdaptiveSelectable extends StatelessWidget {
  const AdaptiveSelectable({
    @required this.child,
    Key key,
    this.onTap,
    this.onLongPress,
  })  : assert(child != null),
        super(key: key);

  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoSelectable(
        onTap: onTap,
        onLongPress: onLongPress,
        child: child,
      );
    } else {
      return InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: child,
      );
    }
  }
}

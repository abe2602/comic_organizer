import 'package:comix_organizer/presentation/common/adaptive_stateless_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFilledButton extends AdaptiveStatelessWidget {
  const AdaptiveFilledButton({
    @required this.child,
    @required this.onPressed,
    this.width,
    this.height,
    this.backgroundColor,
  })  : assert(child != null),
        assert(onPressed != null);

  final Widget child;
  final Function onPressed;
  final Color backgroundColor;
  final double width;
  final double height;

  @override
  Widget buildCupertinoWidget(BuildContext context) => Container(
    width: width,
    height: height,
    child: CupertinoButton(
          color: backgroundColor,
          onPressed: onPressed,
          child: child,
        ),
  );

  @override
  Widget buildMaterialWidget(BuildContext context) => Container(
    width: width,
    height: height,
    child: MaterialButton(
          color: backgroundColor,
          onPressed: onPressed,
          child: child,
        ),
  );
}

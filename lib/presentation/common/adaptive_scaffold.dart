import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'adaptive_stateless_widget.dart';

class AdaptiveScaffold extends AdaptiveStatelessWidget {
  const AdaptiveScaffold({
    @required this.body,
    Key key,
    this.title,
    this.backgroundColor,
    this.onPressed,
  })  : assert(body != null),
        super(key: key);

  final String title;
  final Widget body;
  final Color backgroundColor;
  final Function onPressed;

  @override
  Widget buildCupertinoWidget(BuildContext context) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            title,
            maxLines: 1,
          ),
          trailing: onPressed != null
              ? CupertinoButton(
                  onPressed: onPressed,
                  padding: EdgeInsets.zero,
                  child: Text('+'),
                )
              : null,
        ),
        backgroundColor: backgroundColor,
        child: SafeArea(child: body),
      );

  @override
  Widget buildMaterialWidget(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            maxLines: 1,
          ),
        ),
        body: body,
        backgroundColor: backgroundColor,
        floatingActionButton: onPressed != null
            ? FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: onPressed,
                child: Text('+'),
              )
            : null,
      );
}

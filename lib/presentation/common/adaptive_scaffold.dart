import 'package:comix_organizer/presentation/common/view_utils.dart';
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
    this.scaffoldAction,
    this.type = PageType.root,
  })  : assert(body != null),
        assert(type != null),
        super(key: key);

  final String title;
  final Widget body;
  final Color backgroundColor;
  final Function scaffoldAction;
  final PageType type;

  @override
  Widget buildCupertinoWidget(BuildContext context) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            title,
            maxLines: 1,
          ),
          trailing: scaffoldAction != null
              ? CupertinoButton(
                  onPressed: scaffoldAction,
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
          leading: type == PageType.root
              ? null
              : type == PageType.modal
                  ? const CloseButton()
                  : const BackButton(),
        ),
        body: body,
        backgroundColor: backgroundColor,
        floatingActionButton: scaffoldAction != null
            ? FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: scaffoldAction,
                child: Text('+'),
              )
            : null,
      );
}

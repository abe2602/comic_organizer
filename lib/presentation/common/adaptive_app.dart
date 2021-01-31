import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'adaptive_stateless_widget.dart';

class AdaptiveApp extends AdaptiveStatelessWidget {
  const AdaptiveApp({
    @required this.onGenerateTitle,
    @required this.primaryColor,
    @required this.initialRoute,
    @required this.onGenerateRoute,
    this.localizationsDelegates,
    this.supportedLocales,
    Key key,
  })  : assert(onGenerateTitle != null),
        assert(primaryColor != null),
        assert(initialRoute != null),
        assert(onGenerateRoute != null),
        super(key: key);

  final GenerateAppTitle onGenerateTitle;
  final Color primaryColor;
  final String initialRoute;
  final RouteFactory onGenerateRoute;
  final Iterable<Locale> supportedLocales;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;

  @override
  Widget buildCupertinoWidget(BuildContext context) => CupertinoApp(
        onGenerateTitle: onGenerateTitle,
        debugShowCheckedModeBanner: false,
        theme: CupertinoThemeData(primaryColor: primaryColor),
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoute,
      );

  @override
  Widget buildMaterialWidget(BuildContext context) => MaterialApp(
        onGenerateTitle: onGenerateTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: primaryColor),
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoute,
      );
}

import 'package:comix_organizer/data/cache/models/book_cm.dart';
import 'package:comix_organizer/data/cache/models/collection_cm.dart';
import 'package:comix_organizer/presentation/collection/collection_page.dart';
import 'package:comix_organizer/presentation/collection_list/collection_list_page.dart';
import 'package:comix_organizer/presentation/common/adaptive_app.dart';
import 'package:comix_organizer/presentation/common/comic_organizer_general_provider.dart';
import 'package:comix_organizer/presentation/add_collection/add_collection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;

  WidgetsFlutterBinding.ensureInitialized();

  Hive
    ..init(
      (await getApplicationDocumentsDirectory()).path,
    )
    ..registerAdapter(
      BookCMAdapter(),
    )
    ..registerAdapter(
      CollectionCMAdapter(),
    );

  runApp(
    ComicOrganizerGeneralProvider(
      builder: (_) => MainWidget(),
    ),
  );
}

class MainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) => AdaptiveApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        primaryColor: Colors.red,
        onGenerateTitle: (context) => S.of(context).appName,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            return MaterialPageRoute(
              builder: (context) => CollectionListPage.create(),
            );
          }

          if (settings.name == '/newCollection') {
            return MaterialPageRoute(
              builder: (context) => AddCollectionPage.create(),
            );
          }

          final uri = Uri.parse(settings.name);
          if (uri.pathSegments.length == 2 &&
              uri.pathSegments.first == 'collection') {
            return MaterialPageRoute(
              builder: (context) => CollectionPage.create(uri.pathSegments[1]),
            );
          }

          return MaterialPageRoute(
            builder: (context) => Container(),
          );
        },
      );
}

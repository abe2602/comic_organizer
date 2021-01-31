import 'package:comix_organizer/data/cache/collection_cds.dart';
import 'package:comix_organizer/data/repository/collection_repository.dart';
import 'package:domain/data_repository/collection_data_repository.dart';
import 'package:domain/use_case/get_collection_list_uc.dart';
import 'package:domain/use_case/get_books_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rxdart/rxdart.dart';

class ComicOrganizerGeneralProvider extends StatelessWidget {
  const ComicOrganizerGeneralProvider({
    @required this.builder,
  }) : assert(builder != null);

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ..._buildStreamProviders(),
          ..._buildCDSProviders(),
           ..._buildRepositoryProviders(),
           ..._buildUseCaseProviders(),
        ],
        child: builder(context),
      );

  List<SingleChildWidget> _buildStreamProviders() => [
        Provider<PublishSubject<void>>(
          create: (_) => PublishSubject<void>(),
          dispose: (context, collectionListSubject) =>
              collectionListSubject.close(),
        ),
      ];

  List<SingleChildWidget> _buildCDSProviders() => [
        ProxyProvider<PublishSubject<void>, CollectionCDS>(
          update: (_, collectionListSubject, __) => CollectionCDS(
            collectionListDataObservableSink: collectionListSubject.sink,
          ),
        ),
      ];

  List<SingleChildWidget> _buildRepositoryProviders() => [
    ProxyProvider<CollectionCDS, CollectionDataRepository>(
      update: (context, collectionCDS, _) => CollectionRepository(
        collectionCDS: collectionCDS,
      ),
    ),
  ];

  List<SingleChildWidget> _buildUseCaseProviders() => [
    ProxyProvider<CollectionDataRepository, GetCollectionListUC>(
      update: (context, collectionRepository, _) => GetCollectionListUC(
        collectionRepository: collectionRepository,
      ),
    ),
    ProxyProvider<CollectionDataRepository, GetBooksListUC>(
      update: (context, collectionRepository, _) => GetBooksListUC(
        collectionRepository: collectionRepository,
      ),
    ),
  ];
}

import 'package:comix_organizer/presentation/common/input_status_vm.dart';
import 'package:comix_organizer/presentation/common/subscription_utils.dart';
import 'package:comix_organizer/presentation/add_collection/add_collection_models.dart';
import 'package:domain/exceptions.dart';
import 'package:domain/use_case/add_collection_uc.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain/use_case/validate_empty_text_uc.dart';
import 'package:comix_organizer/presentation/common/view_utils.dart';

class AddCollectionBloc with SubscriptionBag {
  AddCollectionBloc({
    @required this.validateEmptyTextUC,
    @required this.addCollectionUC,
  })  : assert(validateEmptyTextUC != null),
        assert(addCollectionUC != null) {
    _onNameFocusLostSubject
        .listen(
          (_) => _buildCollectionNameValidationStream(_nameInputStatusSubject),
        )
        .addTo(subscriptionsBag);

    _onCollectionSizeFocusLostSubject
        .listen(
          (_) => _buildCollectionSizeValidationStream(
              _collectionSizeInputStatusSubject),
        )
        .addTo(subscriptionsBag);

    _onAddCollectionSubject
        .flatMap(
          (_) => Future.wait(
            [
              _buildCollectionNameValidationStream(_nameInputStatusSubject),
              _buildCollectionSizeValidationStream(
                  _collectionSizeInputStatusSubject),
            ],
            eagerError: false,
          ).asStream(),
        )
        .flatMap(
          (_) => _addCollection(),
        )
        .listen((_) {})
        .addTo(subscriptionsBag);
  }

  final AddCollectionUC addCollectionUC;
  final ValidateEmptyTextUC validateEmptyTextUC;

  // Actions
  final _onNewActionSubject = PublishSubject<AddCollectionAction>();

  Stream<AddCollectionAction> get onNewAction => _onNewActionSubject.stream;

  // Button Click
  final _onAddCollectionSubject = PublishSubject<void>();

  Sink<void> get onAddCollectionSink => _onAddCollectionSubject.sink;

  // Image path
  final _onImageAddedSubject = BehaviorSubject<String>();

  Sink<String> get onImageAddedSink => _onImageAddedSubject.sink;

  // Collection Name
  final _onNameValueChangedSubject = BehaviorSubject<String>();
  final _nameInputStatusSubject = PublishSubject<InputStatusVM>();
  final _onNameFocusLostSubject = PublishSubject<void>();

  String get collectionNameValue => _onNameValueChangedSubject.stream.value;

  Sink<String> get onNameValueChangedSink => _onNameValueChangedSubject.sink;

  Sink<void> get onNameFocusLostSink => _onNameFocusLostSubject.sink;

  Stream<InputStatusVM> get nameInputStatusStream =>
      _nameInputStatusSubject.stream;

  // Collection Size
  final _onCollectionSizeValueChangedSubject = BehaviorSubject<String>();
  final _collectionSizeInputStatusSubject = PublishSubject<InputStatusVM>();
  final _onCollectionSizeFocusLostSubject = PublishSubject<void>();

  String get collectionSizeValue =>
      _onCollectionSizeValueChangedSubject.stream.value;

  Sink<String> get onCollectionSizeValueChangedSink =>
      _onCollectionSizeValueChangedSubject.sink;

  Sink<void> get onCollectionSizeFocusLostSink =>
      _onCollectionSizeFocusLostSubject.sink;

  Stream<InputStatusVM> get collectionSizeInputStatusStream =>
      _collectionSizeInputStatusSubject.stream;

  // Functions
  Future<void> _buildCollectionNameValidationStream(Sink<InputStatusVM> sink) =>
      validateEmptyTextUC
          .getFuture(
            params: ValidateEmptyTextUCParams(collectionNameValue),
          )
          .addStatusToSink(sink);

  Future<void> _buildCollectionSizeValidationStream(Sink<InputStatusVM> sink) =>
      validateEmptyTextUC
          .getFuture(
            params: ValidateEmptyTextUCParams(collectionSizeValue),
          )
          .addStatusToSink(sink);

  Stream<AddCollectionStateResponse> _addCollection() async* {
    yield Loading();

    try {
      await addCollectionUC.getFuture(
        params: AddCollectionParamsUC(
          collectionName: collectionNameValue,
          collectionSize: int.parse(collectionSizeValue),
          imagePath: _onImageAddedSubject.value,
        ),
      );

      _onNewActionSubject.sink.add(Success());
    } catch (error) {
      if (error is CollectionAlreadyAddedException) {
        _onNewActionSubject.sink.add(CollectionAlreadyAddedError());
      } else {
        _onNewActionSubject.sink.add(GenericError());
      }
    }
  }

  void dispose() {
    _onNewActionSubject.close();
    _onAddCollectionSubject.close();
    _onNameValueChangedSubject.close();
    _nameInputStatusSubject.close();
    _onNameFocusLostSubject.close();
    _onCollectionSizeValueChangedSubject.close();
    _collectionSizeInputStatusSubject.close();
    _onCollectionSizeFocusLostSubject.close();
    _onImageAddedSubject.close();
  }
}

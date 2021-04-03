// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// ``
  String get appName {
    return Intl.message(
      '',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Generic Error`
  String get genericErrorMessage {
    return Intl.message(
      'Generic Error',
      name: 'genericErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgainButtonLabel {
    return Intl.message(
      'Try Again',
      name: 'tryAgainButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Looks like there's no internet , \n Try to connect into internet ;)`
  String get noInternetMessage {
    return Intl.message(
      'Looks like there\'s no internet , \n Try to connect into internet ;)',
      name: 'noInternetMessage',
      desc: '',
      args: [],
    );
  }

  /// `Empty Field`
  String get emptyFieldError {
    return Intl.message(
      'Empty Field',
      name: 'emptyFieldError',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Field`
  String get invalidFieldError {
    return Intl.message(
      'Invalid Field',
      name: 'invalidFieldError',
      desc: '',
      args: [],
    );
  }

  /// `Collection Name`
  String get nameLabel {
    return Intl.message(
      'Collection Name',
      name: 'nameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add a new Collection`
  String get addNewCollectionTitle {
    return Intl.message(
      'Add a new Collection',
      name: 'addNewCollectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Collection Size`
  String get collectionSizeLabel {
    return Intl.message(
      'Collection Size',
      name: 'collectionSizeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get addedWithSuccessTitle {
    return Intl.message(
      'Success',
      name: 'addedWithSuccessTitle',
      desc: '',
      args: [],
    );
  }

  /// `Collection added with success`
  String get addedWithSuccessText {
    return Intl.message(
      'Collection added with success',
      name: 'addedWithSuccessText',
      desc: '',
      args: [],
    );
  }

  /// `Ok!`
  String get addedWithSuccessButtonText {
    return Intl.message(
      'Ok!',
      name: 'addedWithSuccessButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Comic Collection`
  String get comicCollectionTitle {
    return Intl.message(
      'Comic Collection',
      name: 'comicCollectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Collection already added`
  String get comicAlreadyAddedTitle {
    return Intl.message(
      'Collection already added',
      name: 'comicAlreadyAddedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Collection with this name already added`
  String get comicAlreadyAddedText {
    return Intl.message(
      'Collection with this name already added',
      name: 'comicAlreadyAddedText',
      desc: '',
      args: [],
    );
  }

  /// `Ok!`
  String get comicAlreadyAddedButtonText {
    return Intl.message(
      'Ok!',
      name: 'comicAlreadyAddedButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get addNewCollectionButtonText {
    return Intl.message(
      'Save',
      name: 'addNewCollectionButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Image from Galery`
  String get imageFromLibraryText {
    return Intl.message(
      'Image from Galery',
      name: 'imageFromLibraryText',
      desc: '',
      args: [],
    );
  }

  /// `Image from Camera`
  String get imageFromCameraText {
    return Intl.message(
      'Image from Camera',
      name: 'imageFromCameraText',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
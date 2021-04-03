import 'dart:io';

import 'package:comix_organizer/generated/l10n.dart';
import 'package:comix_organizer/presentation/common/action_handler.dart';
import 'package:comix_organizer/presentation/common/adaptive_filled_button.dart';
import 'package:comix_organizer/presentation/common/adaptive_scaffold.dart';
import 'package:comix_organizer/presentation/common/form_text_field.dart';
import 'package:comix_organizer/presentation/add_collection/add_collection_bloc.dart';
import 'package:comix_organizer/presentation/add_collection/add_collection_models.dart';
import 'package:domain/use_case/add_collection_uc.dart';
import 'package:domain/use_case/validate_empty_text_uc.dart';
import 'package:flutter/cupertino.dart';
import 'package:comix_organizer/presentation/common/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddCollectionPage extends StatefulWidget {
  const AddCollectionPage({
    @required this.bloc,
  }) : assert(bloc != null);

  static Widget create() =>
      ProxyProvider2<ValidateEmptyTextUC, AddCollectionUC, AddCollectionBloc>(
        update: (context, validateEmptyTextUC, addCollectionUC, currentBloc) =>
            currentBloc ??
            AddCollectionBloc(
              addCollectionUC: addCollectionUC,
              validateEmptyTextUC: validateEmptyTextUC,
            ),
        child: Consumer<AddCollectionBloc>(
          builder: (_, bloc, __) => AddCollectionPage(
            bloc: bloc,
          ),
        ),
      );

  final AddCollectionBloc bloc;

  @override
  State<StatefulWidget> createState() => _AddCollectionPageState();
}

class _AddCollectionPageState extends State<AddCollectionPage> {
  final _nameFocusNode = FocusNode();
  final _collectionSizeFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    _nameFocusNode.addFocusLostListener(
      () => widget.bloc.onNameFocusLostSink.add(null),
    );

    _collectionSizeFocusNode.addFocusLostListener(
      () => widget.bloc.onCollectionSizeFocusLostSink.add(null),
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: AdaptiveScaffold(
          title: S.of(context).addNewCollectionTitle,
          type: PageType.modal,
          body: SingleChildScrollView(
            child: ActionHandler(
              actionStream: widget.bloc.onNewAction,
              onReceived: (event) async {
                if (event is Success) {
                  Navigator.of(context).pop(true);
                }

                if (event is CollectionAlreadyAddedError) {
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(S.of(context).comicAlreadyAddedTitle),
                      content: Text(S.of(context).comicAlreadyAddedText),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child:
                              Text(S.of(context).comicAlreadyAddedButtonText),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    _CoverImage(
                      bloc: widget.bloc,
                    ),
                    FormTextField(
                      statusStream: widget.bloc.nameInputStatusStream,
                      focusNode: _nameFocusNode,
                      labelText: S.of(context).nameLabel,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onChanged: widget.bloc.onNameValueChangedSink.add,
                      onEditingComplete: _nameFocusNode.nextFocus,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FormTextField(
                      statusStream: widget.bloc.collectionSizeInputStatusStream,
                      focusNode: _collectionSizeFocusNode,
                      labelText: S.of(context).collectionSizeLabel,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged:
                          widget.bloc.onCollectionSizeValueChangedSink.add,
                      onEditingComplete: () =>
                          widget.bloc.onAddCollectionSink.add(null),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AdaptiveFilledButton(
                      width: MediaQuery.of(context).size.width,
                      backgroundColor: Colors.red,
                      onPressed: () =>
                          widget.bloc.onAddCollectionSink.add(null),
                      child: Text(
                        S.of(context).addNewCollectionButtonText,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class _CoverImage extends StatefulWidget {
  const _CoverImage({
    @required this.bloc,
  }) : assert(bloc != null);

  final AddCollectionBloc bloc;

  @override
  State<StatefulWidget> createState() => _CoverImageState();
}

class _CoverImageState extends State<_CoverImage> {
  File _image;

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          const SizedBox(
            height: 32,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: _image != null
                    ? Image.file(
                        _image,
                        width: 150,
                        height: 150,
                        fit: BoxFit.fitHeight,
                      )
                    : Container(
                        color: Colors.grey[200],
                        width: 150,
                        height: 150,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
          )
        ],
      );

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(S.of(context).imageFromLibraryText),
                onTap: () {
                  _getImageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text(S.of(context).imageFromCameraText),
                onTap: () {
                  _getImageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getImageFromCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);

    setState(
      () {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          widget.bloc.onImageAddedSink.add(_image.path);
        } else {
          print('No image selected.');
        }
      },
    );
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(
      () {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          widget.bloc.onImageAddedSink.add(_image.path);
        } else {
          print('No image selected.');
        }
      },
    );
  }
}

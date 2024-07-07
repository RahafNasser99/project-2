import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/presentation/cubits/add_update_delete_post_cubit/add_update_delete_post_cubit.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/presentation/widgets/add_post_widget.dart';
import 'package:law_platform_mobile_app/utils/global_widgets/loading.dart';
import 'package:law_platform_mobile_app/utils/global_widgets/show_dialog.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostState();
}

class _AddPostState extends State<AddPostPage> {
  bool _isInit = true;
  File? _imageFile;
  String _postBody = '';
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final postData = ModalRoute.of(context)!.settings.arguments != null
          ? ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>
          : null;
      if (postData != null) {
        _textEditingController.text = postData['postBody'];
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _post() {
    BlocProvider.of<AddUpdateDeletePostCubit>(context).addUpdatePost('add', '',
        _postBody, _imageFile?.path, _imageFile?.path.split('/').last);
  }

  void _setImage(File? image) {
    setState(() {
      _imageFile = image;
    });
  }

  void _setPostBody(String postText) {
    _postBody = postText;
  }

  Future _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      File tempImageFile = File(image.path);
      File? croppedImage = await _cropImage(imageFile: tempImageFile);
      croppedImage == null ? _setImage(tempImageFile) : _setImage(croppedImage);
    } on PlatformException catch (error) {
      print(error.message);
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: BlocConsumer<AddUpdateDeletePostCubit, AddUpdateDeletePostState>(
          listener: (context, state) {
            if (state is AddUpdateDeletePostError) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => ShowDialog(
                  dialogMessage: state.errorMessage,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              );
            } else if (state is AddUpdateDeletePostDone) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state is AddUpdateDeletePostLoading) {
              return Loading(
                evenColor: Theme.of(context).colorScheme.primary,
                oddColor: Theme.of(context).colorScheme.secondary,
              );
            } else {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.arrow_back_rounded),
                            ),
                            CircleAvatar(
                              maxRadius: height * 0.035,
                              child: Icon(
                                Icons.person_rounded,
                                size: height * 0.06,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Rahaf Nasser',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton(
                            onPressed: _postBody.isEmpty && _imageFile == null
                                ? null
                                : _post,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                              elevation: 0.0,
                              padding: EdgeInsets.zero,
                              alignment: Alignment.center,
                              shape: const ContinuousRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40.0),
                                ),
                              ),
                            ),
                            child: Text(
                              'نشر',
                              style: TextStyle(
                                fontSize: 22,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  AddPostWidget(
                    postBody: _postBody,
                    postImage: _imageFile?.path,
                    height: height - (height * 0.1) - statusBarHeight,
                    image: _imageFile,
                    textEditingController: _textEditingController,
                    editImage: _pickImage,
                    setImage: _setImage,
                    setPostBody: _setPostBody,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

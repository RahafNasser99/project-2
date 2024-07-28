import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/lawyer_profile.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/member_profile.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/profile.dart';
import 'package:law_platform_flutter/features/profile/presentation/widgets/profile_picture_widget.dart';
import 'package:law_platform_flutter/utils/global_classes/check_authentication.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.profile});

  final Profile profile;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _professionEditingController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final CheckAuthentication _checkAuthentication = CheckAuthentication();
  String newName = '';
  String newProfession = '';
  File? _imageFile;

  @override
  void didChangeDependencies() {
    _nameEditingController.text = widget.profile.name;
    _professionEditingController.text =
        (widget.profile as LawyerProfile).specialization!;
    // if (_checkAuthentication.getAccountType() == 'lawyer' &&
    //     (widget.profile as LawyerProfile).specialization != null) {
    //   _professionEditingController.text =
    //       (widget.profile as LawyerProfile).specialization!;
    // } else if ((widget.profile as MemberProfile).job != null) {
    //   _professionEditingController.text =
    //       (widget.profile as MemberProfile).job!;
    // }

    super.didChangeDependencies();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // send request;
    }
  }

  void _setImage(File? image) {
    setState(() {
      _imageFile = image;
    });
  }

  Future _pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
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
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close_rounded),
        ),
        leadingWidth: 30,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'تعديل الملف الشخصي',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            GestureDetector(
              onTap: _submit,
              child: Text(
                'تم',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10.0,
                      ),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          )),
                      width: double.infinity,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        direction: Axis.vertical,
                        children: <Widget>[
                          ElevatedButton.icon(
                            onPressed: () {
                              _pickImage(ImageSource.camera);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.surface,
                                elevation: 0.0,
                                fixedSize: Size.fromWidth(width - 32.0)),
                            label: const Text('التقاط صورة'),
                            icon: const Icon(Icons.camera_alt_rounded),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              _pickImage(ImageSource.gallery);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.surface,
                                elevation: 0.0,
                                fixedSize: Size.fromWidth(width - 32.0)),
                            label: const Text('اختيار من الاستديو'),
                            icon: const Icon(Icons.image_rounded),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: ProfilePictureWidget(
                  margin: EdgeInsets.only(
                    top: 25.0,
                    right: width * 0.3,
                    left: width * 0.3,
                  ),
                  radius: width * 0.2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 12.0,
                  left: 12.0,
                  top: 25.0,
                ),
                child: Text(
                  'اسم المستخدم',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily:
                        Theme.of(context).textTheme.bodyLarge!.fontFamily,
                    fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                  ),
                  // style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: _nameEditingController,
                    decoration: InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: Theme.of(context).textTheme.labelLarge,
                      prefixIcon: Icon(
                        Icons.person_2_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    validator: (value) {
                      if (value != null && value.trim().isEmpty) {
                        return 'يجب أن تدخل اسم المستخدم';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      newName = value;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 12.0,
                  left: 12.0,
                  top: 25.0,
                ),
                child: Text(
                  'المهنة أو الاختصاص',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily:
                        Theme.of(context).textTheme.bodyLarge!.fontFamily,
                    fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                  ),
                  // style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: _professionEditingController,
                    decoration: InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: Theme.of(context).textTheme.labelLarge,
                      prefixIcon: Icon(
                        Icons.work_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onChanged: (value) {
                      newProfession = value;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

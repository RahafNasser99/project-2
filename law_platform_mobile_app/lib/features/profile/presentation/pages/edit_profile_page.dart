import 'package:flutter/material.dart';
import 'package:law_platform_mobile_app/features/profile/domain/entities/lawyer_profile.dart';
import 'package:law_platform_mobile_app/features/profile/domain/entities/member_profile.dart';
import 'package:law_platform_mobile_app/features/profile/domain/entities/profile.dart';
import 'package:law_platform_mobile_app/utils/global_classes/check_authentication.dart';

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

  @override
  Widget build(BuildContext context) {
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

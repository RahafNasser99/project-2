import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
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
        title: Text(
          'تعديل الملف الشخصي',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        // padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'اسم المستخدم',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
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
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

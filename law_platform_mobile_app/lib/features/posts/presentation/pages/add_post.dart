import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: height * 0.1,
              child: Row(
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
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('نشر'),
                    style: ElevatedButton.styleFrom(
                      shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 12.0, left: 12.0, bottom: 12.0),
              child: TextField(
                textAlign: TextAlign.right,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'عن ماذا تريد أن تتحدث، انشر المعرفة!',
                  hintStyle: Theme.of(context).textTheme.labelLarge,
                  hintTextDirection: TextDirection.rtl,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

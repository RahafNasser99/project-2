import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.only(right: 10.0, left: 10.0, bottom: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.zero,
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(30)),
            leading: CircleAvatar(
              child: Icon(
                Icons.person_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: Text(
              'رهف نصر',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Text(
            'الاستشارة القانونية هي الآلية التي تُحدد الوصف والتكييف القانوني للنازلة. حيث أن الغرض من طلب الاستشارة القانونية هو تبين وجهة نظر القانون في النزاع أو المسألة القانونية التي عُرضت على القضاء أو ستُعرض عليه مُستقبلًا. قصد ضمان الحق أو المركز المادي المتوخي من الخصومة.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

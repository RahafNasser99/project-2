import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: (width - 32.0) * 0.85,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'رهف نصر',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'الاستشارة القانونية هي الآلية التي تُحدد الوصف والتكييف القانوني للنازلة. حيث أن الغرض من طلب الاستشارة القانونية هو تبين وجهة نظر القانون في النزاع أو المسألة القانونية التي عُرضت على القضاء أو ستُعرض عليه مُستقبلًا. قصد ضمان الحق أو المركز المادي المتوخي من الخصومة.',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Container(
            margin: const EdgeInsets.only(top: 16.0),
            width: (width - 32.0) * 0.15,
            child: CircleAvatar(
              child: Icon(
                Icons.person_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

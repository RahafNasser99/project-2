import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        boxShadow: [
          BoxShadow(
            spreadRadius: 2.0,
            blurRadius: 2.0,
            color: Colors.grey[200]!,
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.pink,
            ),
            title: Text('رهف نصر'),
          ),
          Text(
              'الاستشارة القانونية هي الآلية التي تُحدد الوصف والتكييف القانوني للنازلة. حيث أن الغرض من طلب الاستشارة القانونية هو تبين وجهة نظر القانون في النزاع أو المسألة القانونية التي عُرضت على القضاء أو ستُعرض عليه مُستقبلًا. قصد ضمان الحق أو المركز المادي المتوخي من الخصومة. وبالتالي فإن كان الطبيب هو المختص في علاج الامراض التي نصاب بها من حين لاخر، ذلك انه في حال شعورنا بمرض أو وعكة صحية نتوجه للطبيب فان الاختصاص في حالة وقعتنا في مشكل أو ورطة يؤطرها القانون يرجع الاختصاص للمستشار القانوني أو المحامي.'),
        ],
      ),
    );
  }
}

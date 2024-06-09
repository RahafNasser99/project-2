import 'package:flutter/material.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/presentation/widgets/interaction_widget.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        boxShadow: [
          BoxShadow(
            spreadRadius: 2.0,
            blurRadius: 2.0,
            color: Colors.grey[300]!,
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
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
          Padding(
            padding:
                const EdgeInsets.only(right: 12.0, left: 12.0, bottom: 6.0),
                // arabic text => alignment to right , english => to left
            child: Text(
              'الاستشارة القانونية هي الآلية التي تُحدد الوصف والتكييف القانوني للنازلة. حيث أن الغرض من طلب الاستشارة القانونية هو تبين وجهة نظر القانون في النزاع أو المسألة القانونية التي عُرضت على القضاء أو ستُعرض عليه مُستقبلًا. قصد ضمان الحق أو المركز المادي المتوخي من الخصومة. وبالتالي فإن كان الطبيب هو المختص في علاج الامراض التي نصاب بها من حين لاخر، ذلك انه في حال شعورنا بمرض أو وعكة صحية نتوجه للطبيب فان الاختصاص في حالة وقعتنا في مشكل أو ورطة يؤطرها القانون يرجع الاختصاص للمستشار القانوني أو المحامي.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Image.network(
              fit: BoxFit.cover,
              'https://static.wixstatic.com/media/1cd646_ae7f0376474742e4ac9a0dee2f3f5a5d~mv2_d_2508_1672_s_2.jpg/v1/fill/w_925,h_616,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/1cd646_ae7f0376474742e4ac9a0dee2f3f5a5d~mv2_d_2508_1672_s_2.jpg',
            ),
          ),
          const InteractionWidget(),
        ],
      ),
    );
  }
}

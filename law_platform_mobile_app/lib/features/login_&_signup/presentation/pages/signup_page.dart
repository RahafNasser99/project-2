import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/presentation/widgets/signup_credentials.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: height * 0.4,
                  color: Colors.grey[100],
                ),
                Container(
                  color: Colors.grey[100],
                  height: height * 0.6,
                  child: ClipPath(
                    clipper: WaveClipperTwo(reverse: true),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo[400],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SignUpCredentials(height: height, width: width),
          ],
        ),
      ),
    );
  }
}

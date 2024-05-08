import 'package:flutter/material.dart';

class LoginCredentials extends StatefulWidget {
  const LoginCredentials(
      {super.key, required this.height, required this.width});

  final double height;
  final double width;

  @override
  State<LoginCredentials> createState() => _LoginCredentialsState();
}

class _LoginCredentialsState extends State<LoginCredentials> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: EdgeInsets.only(
        top: widget.height * 0.33,
        left: widget.width * 0.06,
        right: widget.width * 0.06,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            color: Colors.grey[100]!,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "منصة قانون",
            style: TextStyle(
                color: Colors.indigo[600],
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                fontFamily: 'Cairo'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              decoration: InputDecoration(
                hintTextDirection: TextDirection.rtl,
                hintText: 'البريد الاكتروني',
                prefixIcon: Icon(
                  Icons.mail,
                  color: Colors.indigo[600],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              obscureText: _hidePassword,
              decoration: InputDecoration(
                  hintText: 'كلمة المرور',
                  prefixIcon: Icon(
                    Icons.key,
                    color: Colors.indigo[600],
                  ),
                  suffix: GestureDetector(
                    onTap: () {
                      setState(() {
                        _hidePassword = !_hidePassword;
                      });
                    },
                    child: Icon(
                      _hidePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.indigo[600],
                    ),
                  )),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo[600],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              fixedSize: Size.fromWidth(widget.width * 0.9),
              elevation: 2.0,
            ),
            child: const Text(
              "تسجيل الدخول",
              style: TextStyle(fontFamily: 'Cairo', color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('signup-page');
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  side: BorderSide(color: Colors.indigo[600]!)),
              fixedSize: Size.fromWidth(widget.width * 0.9),
              elevation: 2.0,
            ),
            child: Text(
              "إنشاء حساب",
              style: TextStyle(fontFamily: 'Cairo', color: Colors.indigo[600]),
            ),
          ),
        ],
      ),
    );
  }
}

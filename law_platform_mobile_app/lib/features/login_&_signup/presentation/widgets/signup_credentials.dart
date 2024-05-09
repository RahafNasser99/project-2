import 'package:flutter/material.dart';

class SignUpCredentials extends StatefulWidget {
  const SignUpCredentials(
      {super.key, required this.height, required this.width});

  final double height;
  final double width;

  @override
  State<SignUpCredentials> createState() => _SignUpCredentialsState();
}

class _SignUpCredentialsState extends State<SignUpCredentials> {
  bool _hidePassword = true;
  bool _lawyer = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(
        horizontal: widget.width * 0.06,
        vertical: widget.height * 0.2,
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
            height: 15.0,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              obscureText: _hidePassword,
              decoration: InputDecoration(
                  hintText: 'تأكيد كلمة المرور',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'حساب محامي',
                style: TextStyle(
                  color: Colors.indigo[900],
                  fontSize: 16,
                ),
              ),
              Checkbox(
                value: _lawyer,
                side: BorderSide(
                  color: Colors.indigo[900]!,
                  width: 2,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                checkColor: Colors.indigo[900],
                activeColor: Colors.indigo[100],
                onChanged: (value) {
                  setState(() {
                    _lawyer = value!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo[600]!,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              fixedSize: Size.fromWidth(widget.width * 0.9),
              elevation: 2.0,
            ),
            child: const Text(
              "تم",
              style: TextStyle(fontFamily: 'Cairo', color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo[50],
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(color: Colors.indigo[100]!),
              ),
              fixedSize: Size.fromWidth(widget.width * 0.9),
              elevation: 2.0,
            ),
            child: Text(
              "تسجيل الدخول",
              style: TextStyle(fontFamily: 'Cairo', color: Colors.indigo[600]!),
            ),
          ),
        ],
      ),
    );
  }
}

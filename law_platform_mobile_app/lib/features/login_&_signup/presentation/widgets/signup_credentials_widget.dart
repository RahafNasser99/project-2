import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/presentation/cubits/signup_cubits/cubit/signup_cubit.dart';
import 'package:law_platform_mobile_app/utils/enum/account_type_enum.dart';

class SignUpCredentialsWidget extends StatefulWidget {
  const SignUpCredentialsWidget(
      {super.key, required this.height, required this.width});

  final double height;
  final double width;

  @override
  State<SignUpCredentialsWidget> createState() => _SignUpCredentialsWidgetState();
}

class _SignUpCredentialsWidgetState extends State<SignUpCredentialsWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController1 = TextEditingController();
  final _passwordController2 = TextEditingController();
  bool _hidePassword = true;
  bool _lawyer = false;
  String _email = '';
  String _password = '';

  void _submit() {
    print('submit');
    print(_email);
    print(_password);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      print(_email);
      print(_password);
      BlocProvider.of<SignupCubit>(context).signUp(
          _email, _password, _lawyer ? AccountType.lawyer : AccountType.member);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: EdgeInsets.only(
        top: widget.height * 0.2,
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
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("منصة قانون",
                style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(
              height: 20.0,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                  hintText: 'البريد الاكتروني',
                  hintStyle: Theme.of(context).textTheme.labelLarge,
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                validator: (value) {
                  if (value != null && value.trim().isEmpty) {
                    return 'يجب أن تدخل البريد الالكتروني';
                  }
                  if (value != null &&
                      (!value.trim().endsWith('@qanon.com') ||
                          value.trim().length <= 10)) {
                    return 'البريد الاكتروني غير صحيح';
                  }
                  return null;
                },
                onChanged: (value) {
                  print('on saved email');
                  _email = value.trim();
                },
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: _passwordController1,
                obscureText: _hidePassword,
                decoration: InputDecoration(
                  hintText: 'كلمة المرور',
                  hintStyle: Theme.of(context).textTheme.labelLarge,
                  prefixIcon: Icon(
                    Icons.key,
                    color: Theme.of(context).colorScheme.primary,
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
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value != null && value.trim().isEmpty) {
                    return 'يجب أن تدخل كلمة المرور';
                  }
                  if (value != null && value.trim().length < 8) {
                    return 'كلمة المرور أقل من 6 محارف';
                  }
                  return null;
                },
                onChanged: (value) {
                  _password = value.trim();
                  print('on saved pass');
                  print(value);
                  print(_password);
                },
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: _passwordController2,
                obscureText: _hidePassword,
                decoration: InputDecoration(
                  hintText: 'تأكيد كلمة المرور',
                  hintStyle: Theme.of(context).textTheme.labelLarge,
                  prefixIcon: Icon(
                    Icons.key,
                    color: Theme.of(context).colorScheme.primary,
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
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value != null && value.trim() != _password) {
                    return 'كلمة المرور غير متطابقة';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  print(newValue);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('حساب محامي',
                    style: Theme.of(context).textTheme.labelLarge),
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
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                fixedSize: Size.fromWidth(widget.width * 0.9),
                elevation: 2.0,
              ),
              child: Text(
                "تم",
                style: TextStyle(
                  fontFamily: 'Lateef',
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  side: BorderSide(color: Colors.indigo[100]!),
                ),
                fixedSize: Size.fromWidth(widget.width * 0.9),
                elevation: 2.0,
              ),
              child: Text(
                "تسجيل الدخول",
                style: TextStyle(
                  fontFamily: 'Lateef',
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

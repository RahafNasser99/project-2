import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:law_platform_mobile_app/utils/enum/account_type_enum.dart';
import 'package:law_platform_mobile_app/utils/global_widgets/loading.dart';
import 'package:law_platform_mobile_app/utils/global_widgets/show_dialog.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/presentation/cubits/signup_cubits/cubit/signup_cubit.dart';

class SignUpCredentialsWidget extends StatefulWidget {
  const SignUpCredentialsWidget(
      {super.key, required this.height, required this.width});

  final double height;
  final double width;

  @override
  State<SignUpCredentialsWidget> createState() =>
      _SignUpCredentialsWidgetState();
}

class _SignUpCredentialsWidgetState extends State<SignUpCredentialsWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController1 = TextEditingController();
  final _passwordController2 = TextEditingController();
  bool _hidePassword = true;
  bool _lawyer = false;
  String _name = '';
  String _email = '';
  String _password = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      BlocProvider.of<SignupCubit>(context).signUp(
        _name,
        _email,
        _password,
        _lawyer ? AccountType.lawyer : AccountType.member,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpError) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => ShowDialog(
              dialogMessage: state.errorMessage,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          );
        } else if (state is SignUpDone) {
          Navigator.of(context).pushReplacementNamed('home-page');
        }
      },
      builder: (context, state) {
        if (state is SignUpLoading) {
          return Container(
            height: widget.height * 0.7,
            padding: const EdgeInsets.all(20.0),
            margin: EdgeInsets.only(
              top: widget.height * 0.15,
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
            child: Loading(
              evenColor: Theme.of(context).colorScheme.primary,
              oddColor: Theme.of(context).colorScheme.secondary,
            ),
          );
        } else {
          return Container(
            padding: const EdgeInsets.all(20.0),
            margin: EdgeInsets.only(
              top: widget.height * 0.15,
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
                  Text(
                    "منصة قانون",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintTextDirection: TextDirection.rtl,
                        hintText: 'اسم المستخدم',
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
                      onChanged: (value) {
                        _name = value.trim();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
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
                          return 'كلمة المرور أقل من 8 محارف';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _password = value.trim();
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
                      onSaved: (newValue) {},
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('مختص في القانون',
                          style: Theme.of(context).textTheme.bodyLarge),
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
                      Navigator.of(context).pushReplacementNamed('login-page');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
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
      },
    );
  }
}

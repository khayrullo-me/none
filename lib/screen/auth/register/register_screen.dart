import 'dart:async';

import 'package:app_bloc/auth/auth_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/colors.dart';
import '../../../utils/widgets.dart';
import '../components/buttons.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  bool allOkay = false;
  bool passwordOkay = false;
  bool passwordEqual = false;
  bool emailOkay = false;
  Timer? _debounce; // Matnni tekshirishni kechiktiruvchi timer

  final bloc = AuthBloc();
  bool obscureText = false;

  final List<Color> _colors1 = [Color(0xFF02AAB0), Color(0xFF00CDAC)];
  final List<Color> _colors2 = [Color(0xFF13547A), Color(0xFF80D0C7)];
  bool _toggle = true;

  void _showSnackBar(String message, Color color, Color textColor) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      backgroundColor: color,
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void emailValidate() {
    // Timer to alternate between gradients

    emailController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();

      _debounce = Timer(const Duration(seconds: 2), () {
        final text = emailController.text;
        setState(() {
          if (text.isEmpty) {
            emailOkay = false;
            _showSnackBar("Email kiriting",
                ColorHelper.primaryDark.withAlpha(10), ColorHelper.red);
          } else if (isValidEmail(text)) {
            emailOkay = true;
            _showSnackBar("Email to'g'ri ✅", ColorHelper.green,
                ColorHelper.textColorSecond);
          } else {
            emailOkay = false;
            _showSnackBar("Emailni to'liq kiriting ❌",
                ColorHelper.red.withAlpha(20), ColorHelper.red);
          }
        });
      });
    });
  }

  void passwordValidate() {
    passwordController.addListener(() {
      final password = passwordController.text;
      if (_debounce?.isActive ?? false) _debounce!.cancel();

      _debounce = Timer(const Duration(seconds: 1), () {
        setState(() {
          if (password.isEmpty) {
            passwordOkay = false;
            _showSnackBar("Passwordni kiriting",
                ColorHelper.primaryDark.withAlpha(10), ColorHelper.red);
          } else if (isStrongPassword(password)) {
            passwordOkay = true;
            _showSnackBar("Password to'g'ri ✅", ColorHelper.green,
                ColorHelper.textColorSecond);
          } else {
            passwordOkay = false;
            _showSnackBar("Passwordni kuchliroq kiriting",
                ColorHelper.primaryDark.withAlpha(20), ColorHelper.red);
          }
        });
      });
    });
  }

  void passwordEqualty() {
    passwordController2.addListener(() {
      final password = passwordController2.text;
      if (_debounce?.isActive ?? false) _debounce!.cancel();

      _debounce = Timer(const Duration(seconds: 1), () {
        setState(() {
          if (password.isEmpty) {
            passwordOkay = false;
            _showSnackBar("Passwordni tasdiqlang kiriting",
                ColorHelper.primaryDark.withAlpha(10), ColorHelper.red);
          } else if (password == passwordController.text) {
            passwordOkay = true;
            _showSnackBar("Passwordlar birxil to'g'ri ✅", ColorHelper.green,
                ColorHelper.textColorSecond);
          } else {
            passwordOkay = false;
            _showSnackBar("Password xato tasdiqlandi",
                ColorHelper.primaryDark.withAlpha(20), ColorHelper.red);
          }
        });
      });
    });
  }

  @override
  void initState() {
    bloc.add(Init());
    emailValidate();
    passwordValidate();
    passwordEqualty();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _toggle = !_toggle;
      });
    });
    super.initState();
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(email);
  }

  bool isStrongPassword(String password) {
    final hasUpperCase = RegExp(r'[A-Z]').hasMatch(password);

    final hasLowerCase = RegExp(r'[a-z]').hasMatch(password);

    final hasNumber = RegExp(r'[0-9]').hasMatch(password);
    passwordOkay = true;
    return hasUpperCase && hasLowerCase && hasNumber;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.error != null && state.success == false) {
            appShowErrorDialog(state.error!, context);
          } else if (state.success == true) {}
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 40),
                        Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 40),
                        CupertinoTextField(
                          onChanged: (text) {
                            setState(() {
                              emailOkay = isValidEmail(text);
                            });
                          },
                          controller: emailController,
                          placeholder: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: CupertinoColors.systemGrey3),
                          ),
                        ),
                        SizedBox(height: 16),
                        CupertinoTextField(
                          onChanged: (text) {
                            setState(() {
                              passwordOkay = isStrongPassword(text);
                            });
                          },
                          controller: passwordController,
                          placeholder: 'Parol',
                          obscureText: obscureText,
                          // Toggle this value
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Theme.of(context).primaryColorLight),
                          ),
                          suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureText =
                                    !obscureText; // Toggle obscureText
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                obscureText ? "Show" : "Hide",
                                style: GoogleFonts.poppins(
                                    color: ColorHelper.iconLight,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        CupertinoTextField(
                          onChanged: (text) {
                            setState(() {
                              passwordEqual = text == passwordController.text;
                            });
                          },
                          controller: passwordController2,
                          placeholder: 'Parolni qayta kiritish',
                          obscureText: obscureText,
                          // Toggle this value
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Theme.of(context).primaryColorLight),
                          ),
                          suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureText =
                                    !obscureText; // Toggle obscureText
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                obscureText ? "Show" : "Hide",
                                style: GoogleFonts.poppins(
                                    color: ColorHelper.iconLight,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        // Sign In tugmasi
                        AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            gradient: emailOkay && passwordOkay && passwordEqual
                                ? LinearGradient(
                                    colors: _toggle ? _colors1 : _colors2,
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                            color: passwordEqual && emailOkay && passwordOkay
                                ? null
                                : ColorHelper.textColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ElevatedButton(
                            clipBehavior: Clip.none,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                elevation: 0),
                            onPressed:
                                passwordEqual && emailOkay && passwordOkay
                                    ? () {
                                        final email = emailController.text;
                                        final password = emailController.text;
                                        bloc.add(CreateUser(
                                            password: password, email: email));
                                      }
                                    : null,
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 18,
                                color:
                                    passwordEqual && emailOkay && passwordOkay
                                        ? Colors.white
                                        : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        GoogleSignInButton(
                          onTap: () {
                            bloc.add(GoogleSignIn());
                          },
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Allaqachon akkountinggiz bormi?',
                              style: GoogleFonts.poppins(
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ),
                            CupertinoButton(
                              onPressed: () {
                                context.router.back();
                              },
                              padding: EdgeInsets.zero,
                              child: Text(
                                '  Sign In',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: ColorHelper.green),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  AppLoading(show: state.loading == true)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

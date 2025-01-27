import 'package:ai_matematik/router/app_router.gr.dart';
import 'package:ai_matematik/utils/colors.dart';
import 'package:app_bloc/auth/auth_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../utils/widgets.dart';
import '../components/buttons.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final bloc = AuthBloc();
  bool obscureText = false;

  @override
  void initState() {
    bloc.add(Init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.error != null && state.success == false) {
            appShowErrorDialog(state.error!, context);
          } else if (state.success == true) {
            context.pushRoute(VerificationRoute());
          }
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
                          'Sign in to continue',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 40),
                        CupertinoTextField(
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
                          controller: passwordController,
                          placeholder: 'Password',
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
                        CupertinoButton(
                          color: ColorHelper.textColor,
                          onPressed: () {
                            final email = emailController.text;
                            final password = passwordController.text;

                            bloc.add(
                                CreateUser(password: password, email: email));
                          },
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: ColorHelper.iconDark),
                          ),
                        ),
                        SizedBox(height: 16),
                        GoogleSignInButton(
                          onTap: () {
                            bloc.add(GoogleSignIn());
                          },
                        ),
                        SizedBox(height: 16),
                        CupertinoButton(
                          onPressed: () {
                            // Handle forgot password logic here
                            print('Forgot Password Pressed');
                          },
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.poppins(
                                color: Theme.of(context).secondaryHeaderColor),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don’t have an account?',
                              style: GoogleFonts.poppins(
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ),
                            CupertinoButton(
                              onPressed: () {
                                // Navigate to signup screen
                                print('Sign Up Pressed');
                              },
                              padding: EdgeInsets.zero,
                              child: Text(
                                '  Sign Up',
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(CupertinoApp(
    home: LoginScreen(),
  ));
}

import 'package:ai_matematik/utils/widgets.dart';
import 'package:app_bloc/auth/auth_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final auth = AuthBloc();

  @override
  void initState() {
    auth.add(Init());
    auth.add(CheckIsVerification());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: auth,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.verification == true) {
            appShowErrorDialog("Verificated", context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Verify Your Email'),
            ),
            body: Center(
              child: false
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.verified, color: Colors.green, size: 100),
                        SizedBox(height: 16),
                        Text(
                          'Email is verified!',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to the next screen
                          },
                          child: Text('Continue'),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.email_outlined,
                            color: Colors.grey, size: 100),
                        SizedBox(height: 16),
                        Text(
                          'Please verify your email address.',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        false
                            ? Text(
                                'A verification email has been sent. Check your inbox.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.blueGrey),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  auth.add(EmailVerificate());
                                },
                                child: Text('Send Verification Email'),
                              ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('I have verified my email'),
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

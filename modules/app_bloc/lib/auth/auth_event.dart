part of 'auth_bloc.dart';

sealed class AuthEvent {}

class Init extends AuthEvent {}
class GoogleSignIn extends AuthEvent {}
class EmailVerificate extends AuthEvent {}
class CheckIsVerification extends AuthEvent {}

class LogInEvent extends AuthEvent {
  final String password;
  final String email;

  LogInEvent({required this.password, required this.email});
}

class CreateUser extends AuthEvent {
  final String password;
  final String email;

  CreateUser({required this.password, required this.email});
}

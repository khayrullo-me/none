import 'package:bloc/bloc.dart';
import 'package:core/utils/result_data.dart';
import 'package:data/service/auth/auth_service.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late AuthService auth;

  AuthBloc() : super(AuthState()) {
    on<Init>((event, emit) async {
      emit(state.copyWith(loading: true));
      auth = AuthService();
      await auth.init();
      emit(state.copyWith(loading: false));
    });


    on<CheckIsVerification>((event, emit) async {
      emit(state.copyWith(loading: true));

      final result = await auth.checkVerification();
      emit(state.copyWith(loading: false, verification: result));
    });


    on<GoogleSignIn>((event, emit) async {
      emit(state.copyWith(loading: true));
      final result = await auth.signInWithGoogle();
      if (result is Success) {
        emit(state.copyWith(loading: false, success: true));
      } else {
        emit(state.copyWith(
            loading: false,
            success: false,
            error: (result as Failure).errorMessage));
      }
    });

    on<EmailVerificate>((event, emit) async {
      emit(state.copyWith(loading: true));
      final result = await auth.sendVerificationEmail();
      if (result) {
        emit(state.copyWith(loading: false, success: true));
      } else {
        emit(state.copyWith(loading: false, success: false, error: "Xatoli"));
      }
    });

    on<LogInEvent>((event, emit) async {
      emit(state.copyWith(loading: true));
      final result =
          await auth.loginUser(email: event.email, password: event.password);
      if (result is Success) {
        emit(state.copyWith(loading: false, success: true));
      } else {
        emit(state.copyWith(
            loading: false,
            success: false,
            error: (result as Failure).errorMessage));
      }
    });

    on<CreateUser>((event, emit) async {
      emit(state.copyWith(loading: true));
      final result =
          await auth.createUser(email: event.email, password: event.password);
      if (result is Success) {
        emit(state.copyWith(loading: false, success: true));
      } else {
        emit(state.copyWith(
            loading: false,
            success: false,
            error: (result as Failure).errorMessage));
      }
    });
  }
}

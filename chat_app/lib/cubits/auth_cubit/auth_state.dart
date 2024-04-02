part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginFailure extends AuthState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class ResgisterFailure extends AuthState {
  final String errorMessage;

  ResgisterFailure({required this.errorMessage});
}

final class SignWithGoogleLoading extends AuthState {}

final class SignWithGoogleSuccess extends AuthState {
  final String email;

  SignWithGoogleSuccess({required this.email});
}

final class SignWithGoogleFailure extends AuthState {
  final String errorMessage;

  SignWithGoogleFailure({required this.errorMessage});
}

final class SignWithFacebookLoading extends AuthState {}

final class SignWithFacebookSuccess extends AuthState {
  final String email;

  SignWithFacebookSuccess({required this.email});
}

final class SignWithFacebookFailure extends AuthState {
  final String errorMessage;

  SignWithFacebookFailure({required this.errorMessage});
}

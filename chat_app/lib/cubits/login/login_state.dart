part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}

final class SignWithGoogleLoading extends LoginState {}

final class SignWithGoogleSuccess extends LoginState {}

final class SignWithGoogleFailure extends LoginState {
  final String errorMessage;

  SignWithGoogleFailure({required this.errorMessage});
}

final class SignWithFacebookLoading extends LoginState {}

final class SignWithFacebookSuccess extends LoginState {}

final class SignWithFacebookFailure extends LoginState {
  final String errorMessage;

  SignWithFacebookFailure({required this.errorMessage});
}

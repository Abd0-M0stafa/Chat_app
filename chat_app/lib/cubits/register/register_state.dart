part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {}

final class ResgisterFailure extends RegisterState {
  final String errorMessage;

  ResgisterFailure({required this.errorMessage});
}

final class SignWithGoogleLoading extends RegisterState {}

final class SignWithGoogleSuccess extends RegisterState {}

final class SignWithGoogleFailure extends RegisterState {
  final String errorMessage;

  SignWithGoogleFailure({required this.errorMessage});
}

final class SignWithFacebookLoading extends RegisterState {}

final class SignWithFacebookSuccess extends RegisterState {}

final class SignWithFacebookFailure extends RegisterState {
  final String errorMessage;

  SignWithFacebookFailure({required this.errorMessage});
}

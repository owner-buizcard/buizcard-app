part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SocialLoginEvent extends AuthEvent {
  final String link;

  SocialLoginEvent({required this.link});
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password
  });
}

class SignupEvent extends AuthEvent {
  final String email;
  final String password;
  final String jobTitle;
  final String companyName;
  final String phoneNumber;
  final String name;

  SignupEvent({
    required this.email,
    required this.password,
    required this.jobTitle,
    required this.companyName,
    required this.phoneNumber,
    required this.name
  });
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  ForgotPasswordEvent({
    required this.email
  });
}

class ResetPasswordEvent extends AuthEvent {
  final String link;
  final String password;

  ResetPasswordEvent({
    required this.link,
    required this.password
  });
}

class UploadPictureEvent extends AuthEvent {
  final String picture;

  UploadPictureEvent({
    required this.picture
  });
}

class InitAppEvent extends AuthEvent {}
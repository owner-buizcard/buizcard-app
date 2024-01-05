part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password
  });
}

class NameEvent extends AuthEvent {
  final String name;

  NameEvent({
    required this.name
  });
}

class CompanyInfoEvent extends AuthEvent {
  final String jobTitle;
  final String companyName;

  CompanyInfoEvent({
    required this.jobTitle,
    required this.companyName
  });
}

class ContactEvent extends AuthEvent {
  final String phoneNumber;

  ContactEvent({
    required this.phoneNumber
  });
}

class SignupEvent extends AuthEvent {
  final String email;
  final String password;

  SignupEvent({
    required this.email,
    required this.password
  });
}

class UploadPictureEvent extends AuthEvent {
  final String picture;

  UploadPictureEvent({
    required this.picture
  });
}
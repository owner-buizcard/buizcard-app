part of 'contacts_bloc.dart';

sealed class ContactsState extends Equatable {
  const ContactsState();
  
  @override
  List<Object> get props => [];
}

final class ContactsInitial extends ContactsState {}

class Loading extends ContactsState {}

class Updating extends ContactsState {}

class Creating extends ContactsState {}

class ContactCreated extends ContactsState {}

class ContactDeleted extends ContactsState {}

class Exported extends ContactsState {}

class MailSent extends ContactsState {}

class ContactUpdated extends ContactsState {}

class Failure extends ContactsState {}
part of 'contacts_bloc.dart';

sealed class ContactsState extends Equatable {
  const ContactsState();
  
  @override
  List<Object> get props => [];
}

final class ContactsInitial extends ContactsState {}

class Loading extends ContactsState {}

class ContactCreated extends ContactsState {}

class ContactDeleted extends ContactsState {}

class Failure extends ContactsState {}
part of 'contacts_bloc.dart';

sealed class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class CreateContactEvent extends ContactsEvent {
  final ContactInfo info;

  const CreateContactEvent(this.info);
}
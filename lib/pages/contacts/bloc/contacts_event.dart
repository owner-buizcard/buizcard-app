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

class ExportContactsEvent extends ContactsEvent {
  final String exportId;
  final List ids;

  const ExportContactsEvent({required this.exportId, required this.ids});
}

class DeleteContactEvent extends ContactsEvent {
  final String contactId;

  const DeleteContactEvent({
    required this.contactId
  });
}

class UpdateContactEvent extends ContactsEvent {
  final String contactId;
  final Map data;

  const UpdateContactEvent({
    required this.contactId,
    required this.data
  });
}
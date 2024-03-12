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

class SaveContactEvent extends ContactsEvent {
  final String cardId;
  final String ownerId;

  const SaveContactEvent(this.cardId, this.ownerId);
}

class SendMailEvent extends ContactsEvent {
  final List emails;
  final String subject;
  final String content;

  const SendMailEvent({required this.content, required this.emails, required this.subject});
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
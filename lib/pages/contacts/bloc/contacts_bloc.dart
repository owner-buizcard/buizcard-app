import 'package:bizcard_app/models/contact.dart';
import 'package:bizcard_app/models/contact_info.dart';
import 'package:bizcard_app/network/service/contact_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/global.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ContactsInitial()) {
    on<SaveContactEvent>(_onSaveContact);
    on<CreateContactEvent>(_onCreateContact);
    on<DeleteContactEvent>(_onDeleteContact);
    on<UpdateContactEvent>(_onUpdateContact);
    on<ExportContactsEvent>(_onExportContacts);
    on<SendMailEvent>(_onSendMail);
  }

  var service = ContactService();

  _onSendMail(SendMailEvent event, Emitter emit)async{
    emit(Loading());
    try{
      await service.sendMail({
        'emails': event.emails,
        'subject': event.subject,
        'content': event.content
      });
      emit(MailSent());
    }catch(error){
      emit(Failure());
    }
  }

  _onExportContacts(ExportContactsEvent event, Emitter emit)async{
    emit(Loading());
    try{
      if(event.exportId=='zoho_crm'){
        await service.exportToZohoCRM(ids: event.ids);
      }else if(event.exportId=='hubspot_crm'){
        await service.exportToHubspotCRM(ids: event.ids);
      }else if(event.exportId=='spreadsheet'){
        await service.exportToSpreadsheet(ids: event.ids);
      }
      
      emit(Exported());
    }catch(error){
      emit(Failure());
    }
  }

  _onDeleteContact(DeleteContactEvent event, Emitter emit)async{
    emit(Loading());
    try{
      Global.contacts.value.removeWhere((element) => element.id==event.contactId);
      Global.contacts.notifyListeners();
      await service.deleteContact(contactId: event.contactId);
      emit(ContactDeleted());
    }catch(error){
      emit(Failure());
    }
  }

  _onCreateContact(CreateContactEvent event, Emitter emit)async{
    emit(Loading());
    try{
      var contact = await service.saveContactDetails(details: event.info);
      Global.contacts.value.add(Contact.fromJson(contact));
      Global.contacts.notifyListeners();
      emit(ContactCreated());
    }catch(error){
      emit(Failure());
    }
  }

  _onSaveContact(SaveContactEvent event, Emitter emit)async{
    emit(Creating());
    try{
      var contact = await service.saveContact(cardId: event.cardId, ownerId: event.ownerId);
      Global.contacts.value.add(Contact.fromJson(contact));
      Global.contacts.notifyListeners();
      emit(ContactCreated());
    }catch(error){
      emit(Failure());
    }
  }

  _onUpdateContact(UpdateContactEvent event, Emitter emit)async{
    emit(Loading());
    try{
      var result = await service.updateContactDetails(contactId: event.contactId, data: event.data, loader: true);
      var contact = Contact.fromJson(result);
      var updated = Global.contacts.value.map((e){
        if(e.id==contact.id){
          return contact;
        }
        return e;
      }).toList();

      Global.contacts.value = updated;
      Global.contacts.notifyListeners();
      
      emit(ContactUpdated());
    }catch(error){
      emit(Failure());
    }
  }
}

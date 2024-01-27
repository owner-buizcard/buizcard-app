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
    on<CreateContactEvent>(_onCreateContact);
    on<DeleteContactEvent>(_onDeleteContact);
    on<UpdateContactEvent>(_onUpdateContact);
    on<ExportContactsEvent>(_onExportContacts);
  }

  var service = ContactService();

  _onExportContacts(ExportContactsEvent event, Emitter emit)async{
    emit(Loading());
    try{
      await service.exportToZohoCRM(ids: event.ids);
      emit(Exported());
    }catch(error){
      emit(Failure());
    }
  }

  _onDeleteContact(DeleteContactEvent event, Emitter emit)async{
    emit(Loading());
    try{
      await service.deleteContact(contactId: event.contactId);
      Global.contacts.removeWhere((element) => element.id==event.contactId);
      emit(ContactDeleted());
    }catch(error){
      emit(Failure());
    }
  }

  _onCreateContact(CreateContactEvent event, Emitter emit)async{
    emit(Loading());
    try{
      var contact = await service.saveContactDetails(details: event.info);
      Global.contacts.add(Contact.fromJson(contact));
      emit(ContactCreated());
    }catch(error){
      emit(Failure());
    }
  }

  _onUpdateContact(UpdateContactEvent event, Emitter emit)async{
    emit(Loading());
    try{
      var result = await service.updateContactDetails(contactId: event.contactId, data: event.data);
      var contact = Contact.fromJson(result);
      var updated = Global.contacts.map((e){
        if(e.id==contact.id){
          return contact;
        }
        return e;
      }).toList();

      Global.contacts = updated;
      
      emit(ContactUpdated());
    }catch(error){
      emit(Failure());
    }
  }
}

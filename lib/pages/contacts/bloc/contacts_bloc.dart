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
  }

  var service = ContactService();

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
}

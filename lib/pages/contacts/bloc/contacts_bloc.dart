import 'dart:io';

import 'package:bizcard_app/models/contact.dart';
import 'package:bizcard_app/models/contact_info.dart';
import 'package:bizcard_app/network/service/contact_service.dart';
import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:excel/excel.dart';
import 'package:open_file_plus/open_file_plus.dart';

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

      var ids = event.contacts.map((e) => e.id).toList();
      if(event.exportId=='zoho_crm'){
        await service.exportToZohoCRM(ids: ids);
      }else if(event.exportId=='hubspot_crm'){
        await service.exportToHubspotCRM(ids: ids);
      }else if(event.exportId=='spreadsheet'){
        await service.exportToSpreadsheet(ids: ids);
      }

      if(event.exportId=='csv' || event.exportId=='excel'){
        var dataList = event.contacts.map((e){
          var card = e.card;
          var details = e.details;

          return {
            "name": card!=null ? '${card.name?.firstName??''} ${card.name?.lastName??''}': details?.name??'',
            "phone": card?.phoneNumber??details?.phone??'',
            "email": card?.email??details?.email??'',
            "address": card!=null ? '${card.address?.addressLine1??''} ${card.address?.city??''} ${card.address?.state??''} ${card.address?.country??''} ${card.address?.pincode??''}': details?.location??'',
            "company": card?.company?.companyName??details?.company??'',
            "title": card?.company?.title??details?.title??'',
            "website": card?.company?.companyWebsite??details?.website??''
          };
        }).toList();

        if(event.exportId=='csv'){
          List<List<dynamic>> csvData = [];

          csvData.add(dataList.first.keys.toList());

          for (var data in dataList) {
            csvData.add(data.values.toList());
          }

          String csvString = const ListToCsvConverter().convert(csvData);

          final directory = Directory('/storage/emulated/0/Download');
          final file = File('${directory.path}/buizcard-contacts.csv');
          await file.writeAsString(csvString);
          OpenFile.open(file.path);
        }else{
          final excel = Excel.createExcel();
          final Sheet sheet = excel['Contacts'];
          for (var key in dataList.first.keys) {
            sheet.cell(CellIndex.indexByString('${String.fromCharCode('A'.codeUnitAt(0) + dataList.first.keys.toList().indexOf(key) + 1)}1')).value = TextCellValue(key);
          }
          for (int i = 0; i < dataList.length; i++) {
            final rowData = dataList[i];
            rowData.forEach((key, value) {
              sheet.cell(CellIndex.indexByString('${String.fromCharCode('A'.codeUnitAt(0) + rowData.keys.toList().indexOf(key) + 1)}${i + 2}')).value = TextCellValue(value);
            });
          }
          final directory = Directory('/storage/emulated/0/Download');
          final file = File('${directory.path}/buizcard-contacts.xlsx');
          var fileBytes = excel.save();
          await file.writeAsBytes(fileBytes??[]);
          OpenFile.open(file.path);
        }
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

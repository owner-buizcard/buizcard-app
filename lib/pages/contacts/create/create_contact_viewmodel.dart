import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/extensions/string_ext.dart';
import 'package:bizcard_app/models/contact.dart';
import 'package:bizcard_app/models/contact_info.dart';
import 'package:bizcard_app/pages/contacts/bloc/contacts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/image/image_bloc.dart';

class CreateContactViewModel extends BaseViewModel {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController titleController;
  late TextEditingController companyController;
  late TextEditingController websiteController;
  late TextEditingController locationController;
  late TextEditingController notesController;

  late ValueNotifier<String?> picture;

  final GlobalKey<FormState> formKey = GlobalKey();

  CreateContactViewModel(ContactInfo? info){
    nameController = TextEditingController(text: info?.name);
    emailController = TextEditingController(text: info?.email);
    phoneController = TextEditingController(text: info?.phone);
    titleController = TextEditingController(text: info?.title);
    companyController = TextEditingController(text: info?.company);
    websiteController = TextEditingController(text: info?.website);
    locationController = TextEditingController(text: info?.location);
    notesController = TextEditingController();

    picture = ValueNotifier(null);
  }

  pickImage(BuildContext context, String type){
    context.read<ImageBloc>().add(
      UploadImageEvent(path: type, croptype: type=='banner'? 'rect': 'square'));
  }

  onSave(BuildContext context, Contact? contact){
    if(!formKey.currentState!.validate()){
      return;
    }

    if(contact!=null){
      context.read<ContactsBloc>().add(UpdateContactEvent(
        contactId: contact.id,
        data: {
          "details": ContactInfo(
            name: nameController.trim(), 
            email: emailController.trim(), 
            phone: phoneController.trim(), 
            title: titleController.trim(), 
            company: companyController.trim(), 
            website: websiteController.trim(), 
            location: locationController.trim()
          ).toJson()
        }
      ));
    }else{
      context.read<ContactsBloc>().add(CreateContactEvent(
        ContactInfo(
          name: nameController.trim(), 
          email: emailController.trim(), 
          phone: phoneController.trim(), 
          title: titleController.trim(), 
          company: companyController.trim(), 
          website: websiteController.trim(), 
          location: locationController.trim()
        )
      ));
    }
  }

  
  @override
  void dispose() {

  }

}
import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/extensions/string_ext.dart';
import 'package:bizcard_app/pages/account/bloc/account_bloc.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/image/image_bloc.dart';

class EditAccountViewModel extends BaseViewModel {
  
  late TextEditingController fnameController;
  late TextEditingController lnameController;
  late TextEditingController phoneController;
  late TextEditingController sEmailController;
  late TextEditingController sPhoneController;
  late TextEditingController cnameController;
  late TextEditingController cwebsiteController;
  late TextEditingController designationController;
  late TextEditingController addressController;
  late TextEditingController stateController;
  late TextEditingController countryController;

  late ValueNotifier<String?> picture;

  GlobalKey<FormState> formKey = GlobalKey();

  EditAccountViewModel(){
    var user = Global.user!;

    fnameController = TextEditingController(text: user.firstName);
    lnameController = TextEditingController(text: user.lastName);
    phoneController = TextEditingController(text: user.phoneNumber);
    sEmailController = TextEditingController(text: user.additionalEmail);
    sPhoneController = TextEditingController(text: user.additionalPhoneNumber);
    cnameController = TextEditingController(text: user.companyName);
    cwebsiteController = TextEditingController(text: user.companyWebsite);
    designationController = TextEditingController(text: user.designation);
    addressController = TextEditingController(text: user.address?['addressLine1']);
    stateController = TextEditingController(text: user.address?['state']);
    countryController = TextEditingController(text: user.address?['country']);

    picture = ValueNotifier(user.picture);
  }

  pickImage(BuildContext context, String type){
    context.read<ImageBloc>().add(
      UploadCImageEvent(cardId: 'user', path: type));
  }

  update(BuildContext context){
    FocusScope.of(context).unfocus();

    if(!formKey.currentState!.validate()){
      return;
    }

    var data = {
      "firstName": fnameController.trim(),
      "lastName": lnameController.trim(),
      "phoneNumber": phoneController.trim(),
      "additionalEmail": sEmailController.trim(),
      "additionalPhoneNumber": sPhoneController.trim(),
      "companyName": cnameController.trim(),
      "companyWebsite": cwebsiteController.trim(),
      "designation": designationController.trim(),
      "address": {
        "addressLine1": addressController.trim(),
        "country": countryController.trim(),
        "state": stateController.trim()
      },
      "picture": picture.value
    };

    context.read<AccountBloc>().add(UpdateUserEvent(data: data));
  }

  @override
  void dispose() {

  }

}
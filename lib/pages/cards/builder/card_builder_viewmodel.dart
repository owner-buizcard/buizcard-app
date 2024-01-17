import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/extensions/string_ext.dart';
import 'package:bizcard_app/models/field_value.dart';
import 'package:bizcard_app/pages/cards/bloc/card_bloc.dart';
import 'package:bizcard_app/pages/cards/builder/bottomsheets/edit_link.dart';
import 'package:bizcard_app/models/card.dart' as bizcard;
import 'package:bizcard_app/pages/common/image/image_bloc.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardBuilderViewModel extends BaseViewModel {

  late bizcard.Card card;

  //about 
  late TextEditingController fNameController;
  late TextEditingController lNameController;
  late TextEditingController mNameController;
  late TextEditingController prefixController;
  late TextEditingController bioController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController countryController;
  late TextEditingController pincodeController;

  //business
  late TextEditingController titleController;
  late TextEditingController companyNameController;
  late TextEditingController departmentController;
  late TextEditingController companyWebsiteController;
  late TextEditingController aboutController;

  //images
  late ValueNotifier<String?> picture;
  late ValueNotifier<String?> banner;
  late ValueNotifier<String?> logo;

  //fields
  late ValueNotifier<List<FieldValue>> fields;

  //link editor
  String selectedId = '';
  late TextEditingController linkController;
  late TextEditingController linkTitleController;
  late TextEditingController linkDescController;
  final GlobalKey<FormState> linkKey = GlobalKey();
  bool linkHighlight = false;

  openSheet(BuildContext context, FieldValue value, CardBuilderViewModel viewModel){
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(),
      backgroundColor: Colors.white,
      builder: (_){
        selectedId = value.id;
        linkController.text = value.link;
        linkTitleController.text = value.title;
        return EditLinkSheet(value: value, viewModel: viewModel);
    });
  }

  removeLink(BuildContext context){
    var updated =  fields.value.where((e) => e.id!=selectedId).toList();
    fields.value = [...updated];
    Navigator.pop(context);
  }

  editLink(BuildContext context){
    if(!linkKey.currentState!.validate()){
      return;
    }

    var updated =  fields.value.map((element) { 
      if(element.id==selectedId){
        return FieldValue(
          id: '${fields.value.length+1}', 
          title: linkTitleController.trim(), 
          link: linkController.trim(), 
          icon: element.icon, 
          highlight: linkHighlight
        );
      }
      return element;
    }).toList();

    fields.value = [...updated];

    Navigator.pop(context);
  }

  onSave(BuildContext context){

    FocusScope.of(context).unfocus();

    var cardData = {
      'cardName': 'test card',
      'name': {
        'firstName': fNameController.trim(),
        'lastName': lNameController.trim(),
        'middleName': mNameController.trim(),
        'prefix': prefixController.trim()
      },
      'picture': picture.value,
      'banner': banner.value,
      'logo': logo.value,
      'bio': bioController.trim(),
      'phoneNumber': phoneController.trim(),
      'email': emailController.trim(),
      'address': {
        'addressLine1': addressController.trim(),
        'city': cityController.trim(),
        'state': stateController.trim(),
        'country': countryController.trim(),
        'pincode': pincodeController.trim()
      },
      'company': {
        'title': titleController.trim(),
        'department': departmentController.trim(),
        'companyName': companyNameController.trim(),
        'companyWebsite': companyWebsiteController.trim(),
        'companyDescription': aboutController.trim(),
      },
      'fields': fields.value.map((e) => e.toJson()).toList()
    };

    context.read<CardBloc>().add(SaveCardEvent(card.id, cardData));
  }

  CardBuilderViewModel(String cardId){
    card = Global.cards.value.firstWhere((element) => element.id==cardId);

    fNameController = TextEditingController(text: card.name?.firstName);
    lNameController = TextEditingController(text: card.name?.lastName);
    mNameController = TextEditingController(text: card.name?.middleName);
    prefixController = TextEditingController(text: card.name?.prefix);
    bioController = TextEditingController(text: card.name?.firstName);
    emailController = TextEditingController(text: card.email);
    phoneController = TextEditingController(text: card.phoneNumber);
    addressController = TextEditingController(text: card.address?.addressLine1);
    cityController = TextEditingController(text: card.address?.city);
    stateController = TextEditingController(text: card.address?.state);
    countryController = TextEditingController(text: card.address?.country);
    pincodeController = TextEditingController(text: card.address?.pincode);

    titleController = TextEditingController(text: card.company?.title);
    companyNameController = TextEditingController(text: card.company?.companyName);
    departmentController = TextEditingController(text: card.company?.department);
    companyWebsiteController = TextEditingController(text: card.company?.companyWebsite);
    aboutController = TextEditingController(text: card.company?.companyDescription);

    fields = ValueNotifier(card.fields);

    linkController = TextEditingController();
    linkTitleController = TextEditingController();
    linkDescController = TextEditingController();

    picture = ValueNotifier(card.picture);
    banner = ValueNotifier(card.banner);
    logo = ValueNotifier(card.logo);
  }

  pickImage(BuildContext context, String type){
    context.read<ImageBloc>().add(
      UploadCImageEvent(cardId: card.id, path: type, croptype: type=='banner'? 'rect': 'square'));
  }
  
  @override
  void dispose() {
  
  }

}
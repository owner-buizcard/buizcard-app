import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/models/card.dart' as bizcard;
import 'package:bizcard_app/models/qr_info.dart';
import 'package:bizcard_app/pages/cards/bloc/card_bloc.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QrcodeThemeViewModel extends BaseViewModel {
  
  late String cardId;
  late bizcard.Card card;
  late QrInfo? qrinfo;
  late String? logopath;

  QrcodeThemeViewModel(id){
    cardId = id;
    card = Global.cards.value.firstWhere((element) => element.id==cardId);
    QrInfo? qr = card.qr;
    if(qr?.eyeStyle=="leaf"){
      qr = qr?.copyWith(eyeStyle: "circle");
    }
    qrinfo = qr;
    logopath = null;
  }

  onSave(BuildContext context){
    if(qrinfo!=null){
      context.read<CardBloc>().add(SaveQrEvent(cardId, qrinfo!, qrLogoPath: logopath));
    }
  }
  
  @override
  void dispose() {

  }
}
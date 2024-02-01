import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/pages/widgets/list_item.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:bizcard_app/models/card.dart' as bizcard;
import 'package:flutter/material.dart';

class CardSettingsSheet extends StatelessWidget {
  final Function(bizcard.Card) onClick;
  final String cardId;
  const CardSettingsSheet({super.key, required this.onClick, required this.cardId});

  @override
  Widget build(BuildContext context) {

    var card = Global.cards.value.firstWhere((element) => element.id==cardId);

    final List options = [
      { 'icon': AntIcons.qrcodeOutlined, 'label': 'Show logo in Qr code', 'value': card.qrVisible },
      { 'icon': AntIcons.pauseOutlined, 'label': 'Disable card', 'value': card.status=="INACTIVE" }
    ];


    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 8,
                width: 52,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFD6D6D6),
                  borderRadius: BorderRadius.circular(8)
                ),
              ),
              ...options.map((opt)=>
                ListItem(
                  item: opt, 
                  isSwitch: true,
                  onClick: (v){
                    var updated = opt['label']=="Disable card" 
                      ? card.copyWith(status: v ? "INACTIVE": "ACTIVE")
                      : card.copyWith(qrVisible: v );
                    Global.updateCard(updated);
                    onClick(updated);
                  })
              ).toList()
            ]
          ),
        ),
      ],
    );
  }
}
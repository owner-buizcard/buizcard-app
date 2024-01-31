import 'package:bizcard_app/constants/colors_const.dart';
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/models/card.dart' as bizcard;
import 'package:bizcard_app/pages/widgets/banner_ph.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CardItem extends StatelessWidget {
  final bizcard.Card card;
  final VoidCallback onOptionClick;
  const CardItem({super.key, required this.card, required this.onOptionClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Color(0x268c8c8c), blurRadius: 8)
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(6)
      ),
      child: Column(
        children: [
    
          Expanded(
            flex: 2,
            child: 
            
            Stack(
              children: [
                FractionallySizedBox(
                  heightFactor: 0.75,
                  child: BannerPH(image: card.banner)
                ),
            
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: ColorsConst.border,
                      backgroundImage:card.picture!=null ? NetworkImage(card.picture!) : null,
                      child: card.picture==null ? const Icon(Icons.person, size: 54) : null,
                    ),
                  ),
                )
            
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: '${card.name?.firstName} ${card.name?.lastName}'.titletext(context),
                    subtitle: '${card.email}'.bltext(context),
                    trailing: InkWell(
                      onTap: onOptionClick,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0x55D6D6D6),
                          borderRadius: BorderRadius.circular(6)
                        ),
                        child: const Icon(Icons.more_vert, color: Color(0xFF797272),),
                      ),
                    ),
                  ),
              
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        QrImageView(
                          size: 130,
                          data: card.cardLink??''
                        )
                      ],
                    ),
                  ),
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Updated 1 hour ago'.btext(context),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0x241677FF),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(card.cardName, style: Theme.of(context).textTheme.bodySmall),
                      )
                    ],
                  ),
              
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
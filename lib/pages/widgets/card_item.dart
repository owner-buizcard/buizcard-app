import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/constants/colors_const.dart';
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/models/card.dart' as bizcard;
import 'package:bizcard_app/pages/widgets/banner_ph.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/utils/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../routes/app_routes.dart';
import '../../utils/global.dart';

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
          BoxShadow(color: Color.fromARGB(37, 124, 123, 123), blurRadius: 4)
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        children: [
    
          Expanded(
            flex: 3,
            child: 
            
            Stack(
              children: [
                FractionallySizedBox(
                  heightFactor: 0.80,
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
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: '${card.name?.firstName} ${card.name?.lastName}'.titletext(context),
                    subtitle: '${card.email}'.bltext(context),
                    trailing: const Icon(Icons.badge, size: 36, color: Color.fromARGB(255, 33, 47, 117),),
                  ),

                  const Gap(size: 8),
              
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DottedBorder(
                          dashPattern: const [3, 3],
                          radius: const Radius.circular(12),
                          color: Colors.grey,
                          child: QrImageView(
                            size: 130,
                            data: card.cardLink!,
                            gapless: false,
                            dataModuleStyle: QrDataModuleStyle(
                                dataModuleShape:
                                    card.qr?.codeStyle == "dots"
                                        ? QrDataModuleShape.circle
                                        : QrDataModuleShape.square,
                                color: Global.hexToColor(
                                    card.qr?.fgColor ?? '#000000')),
                            eyeStyle: QrEyeStyle(
                                eyeShape: card.qr?.eyeStyle == "circle"
                                    ? QrEyeShape.circle
                                    : QrEyeShape.square,
                                color: Global.hexToColor(
                                    card.qr?.eyeColor ?? '#000000')),
                            embeddedImageStyle: const QrEmbeddedImageStyle(
                              size: Size(35, 35),
                            ),
                            embeddedImage: card.qr?.logo != null
                                    ? NetworkImage(card.qr!.logo!)
                                        as ImageProvider
                                    : null),
                        )
                      ],
                    ),
                  ),

                  Text(card.cardName),

                  const Gap(size: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: ()=>Navigator.of(context)
                          .pushNamed(Routes.cardBuilder, arguments: card.id),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                          decoration: BoxDecoration(
                            color: const Color(0x55D6D6D6),
                            borderRadius: BorderRadius.circular(24)
                          ),
                          child: const Icon(AntIcons.editOutlined)),
                      ),
                      InkWell(
                        onTap: ()=>Share.share(
                          getShareContent(card.cardLink!), subject: 'My Digital Business Card'
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                          decoration: BoxDecoration(
                            color: const Color(0x55D6D6D6),
                            borderRadius: BorderRadius.circular(24)
                          ),
                          child: const Icon(AntIcons.shareAltOutlined)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0x55D6D6D6),
                          borderRadius: BorderRadius.circular(24)
                        ),
                        child: IconButton(onPressed: onOptionClick, icon: const Icon(Icons.more_vert)))
                    ],
                  )
              
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
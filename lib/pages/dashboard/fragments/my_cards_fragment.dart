import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/database/local_db.dart';
import 'package:bizcard_app/pages/dashboard/dashboard_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/card_item.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../constants/assets_const.dart';
import '../../widgets/gap.dart';

class MyCardsFragment extends StatelessWidget {
  final DashboardViewModel viewModel;
  const MyCardsFragment({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {

    var cards = Global.cards;
    var key = GlobalKey();

    Future.delayed(Duration.zero, (){
      if(LocalDB.showGuide()){
        ShowCaseWidget.of(context).startShowCase([key]);
        LocalDB.launchDone();
      }
    });

    return Container(
      color: const Color(0xfff5f5f5),
      padding: const EdgeInsets.only(bottom: 38),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                Image.asset(AssetsConst.appLogo, width: 36),
                const Gap(size: 16),
                Text('Hi, ',style: GoogleFonts.inter().copyWith(
                    fontSize: 18
                  ),),
                GradientText(
                  'Dhana !',
                  style: GoogleFonts.inter().copyWith(
                    fontSize: 18
                  ),
                  colors: const [
                    Color(0xFFDC2424),
                    Color(0xFF4A569D)
                  ],
                )
              ],
            ),
            actions: [
              IconButton(onPressed: (){}, icon: const Icon(AntIcons.bellOutlined)),
              const Gap(size: 16),
              const CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(AssetsConst.banner),  
              ),
              const Gap(size: 16)
            ],
          ),

          const Gap(size: 8),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Cards', style: GoogleFonts.inter().copyWith(
                  fontSize: 20,
                  height: 0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
                )),
                TextButton(
                  onPressed: (){
                    viewModel.showPreview(context);
                  }, 
                  child: const Text('PREVIEW'))
              ],
            ),
          ),
          
          const Gap(size: 0),
      
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: cards,
              builder: (_, value, __) {
                return Showcase(
                  key: key,
                  description: 'Swipe to see more cards \u2192',
                  descTextStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Colors.black,
                    fontSize: 16
                  ),
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      height: double.infinity,
                      enableInfiniteScroll: false,
                      viewportFraction: 0.94,
                      onPageChanged: (idx, __)  {
                        viewModel.currentCard = Global.cards.value[idx];
                      }
                    ),
                    itemCount: value.length+1,
                    itemBuilder: (context, index, realIndex) {

                      if(index == value.length){
                        return MainCard(
                          color: Colors.grey[100],
                          margin: const EdgeInsets.all(6),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(AssetsConst.useradding),
                              Text('Create new card with unique informations and share!', 
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: Colors.black
                                ),
                                textAlign: TextAlign.center,  
                              ),
                              const Gap(size: 44),
                              SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: ()=>viewModel.openCreateSheet(context, viewModel), 
                                  child: const Text('Create New Card')),
                              )
                            ],
                          )
                        );
                      }

                      var card = value[index];
                      return CardItem(
                        card: card,
                        onOptionClick: ()=>viewModel.openCardOptions(card, context),  
                      );
                    }
                  ),
                );
              }
            ),
          )
      
        ],
      ),
    );
  }
}
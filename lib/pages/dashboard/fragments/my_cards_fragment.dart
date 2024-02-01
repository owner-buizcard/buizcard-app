import 'package:bizcard_app/database/local_db.dart';
import 'package:bizcard_app/pages/dashboard/dashboard_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/card_item.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:showcaseview/showcaseview.dart';

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

    return Padding(
      padding: const EdgeInsets.only(bottom: 38),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('My Cards', style: Theme.of(context).textTheme.titleMedium),
                TextButton(onPressed: (){}, child: const Text('View All'))
              ],
            ),
          ),
      
          const Gap(size: 10),
      
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
                      viewportFraction: 0.94  
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
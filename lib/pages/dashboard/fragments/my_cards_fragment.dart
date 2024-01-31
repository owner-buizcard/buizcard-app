import 'package:bizcard_app/pages/dashboard/dashboard_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/card_item.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../widgets/gap.dart';

class MyCardsFragment extends StatelessWidget {
  final DashboardViewModel viewModel;
  const MyCardsFragment({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {

    var cards = Global.cards;

    return Padding(
      padding: const EdgeInsets.only(bottom: 54),
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
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        height: double.infinity,
                        enableInfiniteScroll: false,
                        viewportFraction: 0.94  
                      ),
                      itemCount: value.length,
                      itemBuilder: (context, index, realIndex) {
                        var card = value[index];
                        return CardItem(
                          card: card,
                          onOptionClick: ()=>viewModel.openCardOptions(card, context),  
                        );
                      }
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FloatingActionButton(
                            onPressed: (){},
                            elevation: 0,
                            backgroundColor: const Color(0x44000000),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(30)
                              )
                            ),
                            child: const Icon(Icons.arrow_back_ios)  
                          ),
                          FloatingActionButton(
                            onPressed: (){}, 
                            elevation: 0,
                            backgroundColor: const Color(0x44000000),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(30)
                              )
                            ),
                            child: const Icon(Icons.arrow_forward_ios))
                        ],
                      ),
                    ),
                  ],
                );
              }
            ),
          )
      
        ],
      ),
    );
  }
}
import 'package:animated_digit/animated_digit.dart';
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/pages/settings/analytics/analytics_viewmodel.dart';
import 'package:bizcard_app/pages/settings/bloc/settings_bloc.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/main_card.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {

  late AnalyticsViewModel _viewModel;

  @override
  void initState() {
    _viewModel = AnalyticsViewModel(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is MyAnalyticsFetched) {
          _viewModel.initialize(state.analytics);

        }

        return Scaffold(
          backgroundColor: const Color(0xfff5f5f5),
          appBar: AppBar(
            title: Text('My Analytics',
                style: GoogleFonts.inter().copyWith(
                    fontSize: 20,
                    height: 0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [

              GridView.builder(
                    itemCount: _viewModel.data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 1.2),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      var item = _viewModel.data[index];
                      return MainCard(
                        color: Colors.white,
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          '${item['label']}'.btext(context, color: 'dark'),
                          AnimatedDigitWidget(
                              value: item['count'] as int,
                              textStyle:
                                  Theme.of(context).textTheme.displayLarge)
                        ],
                      ));
                    }),
              const Gap(size: 32),
              
              Text('Top Performing Cards', style: GoogleFonts.inter().copyWith(
                fontSize: 16,
                height: 0,
                fontWeight: FontWeight.w600,
                color: Colors.black
              )),
              const Gap(size: 32),

              MainCard(
                color: Colors.white,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _viewModel.topCards.length,
                  itemBuilder: (_, index){
                    var card = _viewModel.topCards[index]['card'];
                    var counts = _viewModel.topCards[index]['analytics'];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: (card?['picture']!=null) ? NetworkImage(card!['picture']!) : null,
                            child: card?['picture']==null ? const Icon(Icons.person, size: 28) : null,
                          ),
                          const Gap(size: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text((card!=null? '${card['name']['firstName']} ${card['name']['lastName']}': 'Card'), style: GoogleFonts.inter().copyWith(
                                  fontSize: 16,
                                  height: 0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87
                                )),
                                const Gap(size: 8),
                                Text((card!=null? '${card?['cardName']}': ''), style: GoogleFonts.inter().copyWith(
                                  fontSize: 14,
                                  height: 0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54
                                )),
                              ],
                            ),
                          ),
                          const Gap(size: 12),
                          Badge.count(
                            count: counts['viewCount'],
                            backgroundColor: Colors.blue,
                            largeSize: 23,
                            offset: const Offset(8, -5),
                            child: const Icon(Icons.show_chart_outlined, size: 40)),
                          const Gap(size: 16),
                        ],
                      ),
                    );
                  },
              ))


            ],

          ),
        );
      },
    );
  }
}

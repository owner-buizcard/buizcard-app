import 'package:animated_digit/animated_digit.dart';
import 'package:bizcard_app/extensions/text_ext.dart';
import 'package:bizcard_app/models/analytics_log.dart';
import 'package:bizcard_app/pages/cards/analytics/card_analytics_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/pages/widgets/main_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../bloc/card_bloc.dart';

class CardAnalyticsView extends StatefulWidget {
  final String cardId;
  const CardAnalyticsView({super.key, required this.cardId});

  @override
  State<CardAnalyticsView> createState() => _CardAnalyticsViewState();
}

class _CardAnalyticsViewState extends State<CardAnalyticsView> {
  late CardAnalyticsViewModel _viewModel;

  @override
  void initState() {
    _viewModel = CardAnalyticsViewModel(context);
    context.read<CardBloc>().add(GetCardAnalyticsEvent(widget.cardId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardBloc, CardState>(
      builder: (context, state) {
        if (state is AnalyticsFetched) {
          _viewModel.initialize(state.analytics);
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Card Analytics'),
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
                const Gap(size: 20),
                MainCard(
                  p: const EdgeInsets.only(right: 14, top: 16),
                  child: Column(
                    children: [

                      'Card Views'.btext(context, color: 'darker'),

                      AspectRatio(
                        aspectRatio: 1.70,
                        child: SfCartesianChart(
                            primaryXAxis: const CategoryAxis(),
                            primaryYAxis: const NumericAxis(
                              minimum: 0,
                              interval: 2,
                            ),
                            series: <ColumnSeries<AnalyticsLog, String>>[
                              ColumnSeries<AnalyticsLog, String>(
                                dataSource: state is AnalyticsFetched
                                  ? state.analytics.weekLogViews : [],
                                xValueMapper: (AnalyticsLog log, _) => log.date,
                                yValueMapper: (AnalyticsLog log, _) => log.count,
                              ),
                            ],
                            trackballBehavior: TrackballBehavior(
                              enable: true,
                              lineType: TrackballLineType.vertical,
                              shouldAlwaysShow: true,
                            ),
                          ),
                        ),
                    ],
                  ),
                  ),
              ],
          ),
        );
      },
    );
  }
}

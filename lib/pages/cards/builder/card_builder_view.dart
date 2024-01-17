import 'package:bizcard_app/pages/cards/builder/fragments/about_fragment.dart';
import 'package:bizcard_app/pages/cards/builder/fragments/business_fragment.dart';
import 'package:bizcard_app/pages/cards/builder/fragments/links_fragment.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/image/image_bloc.dart';
import '../bloc/card_bloc.dart';
import 'card_builder_viewmodel.dart';

class CardBuilderView extends StatefulWidget {
  final String cardId;
  const CardBuilderView({super.key, required this.cardId});

  @override
  State<CardBuilderView> createState() => _CardBuilderViewState();
}

class _CardBuilderViewState extends State<CardBuilderView> {
  late CardBuilderViewModel _viewModel;

  @override
  void initState() {
    _viewModel = CardBuilderViewModel(widget.cardId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CardBloc, CardState>(
          listener: (context, state) {
            if (state is Success) {
              Navigator.pop(context);
            }
          },
        ),
        BlocListener<ImageBloc, ImageState>(
          listener: (context, state) {
            if(state is UploadedSuccess){
              if(state.type=='picture'){
                _viewModel.picture.value = state.link;
              }else if(state.type=='banner'){
                _viewModel.banner.value = state.link;
              }
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 30,
          title: Text(_viewModel.card.cardName),
          actions: [
            TextButton(
                onPressed: () => _viewModel.onSave(context),
                child: const Text("Save")),
            const Gap(size: 8)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0x268c8c8c),
                      borderRadius: BorderRadius.circular(8)),
                  child: const TabBar(tabs: [
                    Tab(text: "About"),
                    Tab(text: "Business"),
                    Tab(text: "Links")
                  ]),
                ),
                const Gap(size: 16),
                Expanded(
                    child: TabBarView(
                  children: [
                    AboutFragment(viewModel: _viewModel),
                    BusinessFragment(viewModel: _viewModel),
                    LinksFragment(viewModel: _viewModel)
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/constants/colors_const.dart';
import 'package:bizcard_app/pages/dashboard/cubit/bottomnav_cubit.dart';
import 'package:bizcard_app/pages/dashboard/dashboard_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:bizcard_app/routes/app_routes.dart';
import 'package:bizcard_app/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cards/bloc/card_bloc.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late DashboardViewModel _viewModel;

  @override
  void initState() {
    _viewModel = DashboardViewModel();
    super.initState();
  }

  getColor(isActive) {
    return isActive ? const Color(0xFF000000) : const Color(0xFFB0B0B0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CardBloc, CardState>(
      listener: (context, state) {
        if(state is Created){
          Navigator.pushNamed(context, Routes.cardBuilder, arguments: state.cardId);
        }
      },
      child: BlocBuilder<HomePageCubit, int>(
        builder: (context, bottomNavIndex) {
          return Scaffold(
            appBar: AppBar(
                leading: IconButton(
                    onPressed: () {}, icon: const Icon(AntIcons.menuOutlined)),
                actions: bottomNavIndex == 0
                    ? [
                        const Gap(size: 16),
                        CircleAvatar(
                          backgroundImage: Global.user!.picture != null
                              ? NetworkImage(Global.user!.picture!)
                              : null,
                          backgroundColor: ColorsConst.border,
                          child: Global.user!.picture != null
                            ? null: const Icon(AntIcons.userOutlined),
                        ),
                        const Gap(size: 16)
                      ]
                    : [
                        IconButton(
                          icon: const Icon(AntIcons.exportOutlined),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(AntIcons.shareAltOutlined),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(AntIcons.userAddOutlined),
                          onPressed: ()=>Navigator.pushNamed(context, Routes.createContact),
                        ),
                        const Gap(size: 16)
                      ]),
            body: PageView(
              controller: _viewModel.controller,
              physics: const NeverScrollableScrollPhysics(),
              children: _viewModel.getPages(_viewModel),
            ),
            floatingActionButton: bottomNavIndex == 0
                ? FloatingActionButton(
                    heroTag: 'create',
                    onPressed: () =>
                        _viewModel.openCreateSheet(context, _viewModel),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    child: const Icon(Icons.add, size: 30),
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar.builder(
              itemCount: 4,
              height: 80,
              tabBuilder: (int index, bool isActive) {
                var item = _viewModel.bottomNavItems[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'], color: getColor(isActive)),
                    const Gap(size: 8),
                    Text(item['label'],
                        style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: getColor(isActive)))
                  ],
                );
              },
              activeIndex: bottomNavIndex,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.verySmoothEdge,
              gapWidth: bottomNavIndex == 0 ? null : 0,
              leftCornerRadius: 32,
              rightCornerRadius: 32,
              onTap: (index) => _viewModel.onMove(index, context),
            ),
          );
        },
      ),
    );
  }
}

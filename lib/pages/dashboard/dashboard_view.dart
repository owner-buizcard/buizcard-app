import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:bizcard_app/pages/dashboard/cubit/bottomnav_cubit.dart';
import 'package:bizcard_app/pages/dashboard/dashboard_viewmodel.dart';
import 'package:bizcard_app/pages/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return BlocBuilder<HomePageCubit, int>(
      builder: (context, bottomNavIndex) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {}, icon: const Icon(AntIcons.menuOutlined)),
            actions: bottomNavIndex == 0 
              ? [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/bizcard-spiderlingz.appspot.com/o/test%2Fimage.jpeg?alt=media&token=1542a472-5059-4127-962f-c39c02985d00'),
                ),
                const Gap(size: 16)
            ] 
              : [
                IconButton(
                  icon: const Icon(AntIcons.exportOutlined),
                  onPressed: (){},
                ),
                IconButton(
                  icon: const Icon(AntIcons.shareAltOutlined),
                  onPressed: (){},
                ),
                IconButton(
                  icon: const Icon(AntIcons.userAddOutlined),
                  onPressed: (){},
                ),
                const Gap(size: 16)
            ]
          ),
          body: PageView(
            controller: _viewModel.controller,
            physics: const NeverScrollableScrollPhysics(),
            children: _viewModel.getPages(_viewModel),
          ),
          floatingActionButton: bottomNavIndex == 0
              ? FloatingActionButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(Icons.send),
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
    );
  }
}

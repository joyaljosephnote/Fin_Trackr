import 'package:fin_trackr/constants/constant.dart';
import 'package:fin_trackr/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class FinTrackrBottomNavigation extends StatelessWidget {
  const FinTrackrBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(19),
        topLeft: Radius.circular(19),
      ),
      child: ValueListenableBuilder(
        valueListenable: HoemeScreen.selectedIndexNotifier,
        builder: (BuildContext ctx, int updatedIndex, Widget? _) {
          return BottomNavigationBar(
            currentIndex: updatedIndex,
            onTap: (newIndex) {
              HoemeScreen.selectedIndexNotifier.value = newIndex;
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColor.ftBottomNavigatorColor,
            selectedItemColor: AppColor.ftBottomNavigatorSelectorColor,
            unselectedItemColor: AppColor.ftBottomNavigatorUnSelectorColor,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            selectedFontSize: 13.0,
            unselectedFontSize: 13.0,
            iconSize: 20.0,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.home), label: 'Trans'),
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.stats_chart), label: 'Stats'),
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.server), label: 'Accounts'),
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.settings), label: 'More'),
            ],
          );
        },
      ),
    );
  }
}

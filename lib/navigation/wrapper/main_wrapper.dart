import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

int selectedIndex = 0;



class MainWrapper extends StatefulWidget {
  const MainWrapper({
    required this.navigationShell,
    super.key,
  });
  final StatefulNavigationShell navigationShell;
  void GOTO(int index, String? searchtext){
    AppNavigation.getSearchtext(searchtext!);
    _MainWrapperState().setselected(index);
      navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );
  }

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.black,
        onButtonPressed: (index) {
          MainWrapper(navigationShell: widget.navigationShell,).GOTO(index,"");
        },
        iconSize: 25,
        inactiveColor: Color(0xffCCC5BD),
        activeColor: lightyellow,
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(
            icon: Icons.home,
            title: 'Home',
          ),
          BarItem(
            icon: Icons.sports_gymnastics,
            title: 'Classes',
          ),
          BarItem(
            icon: Icons.qr_code_scanner,
            title: 'Check-In',
          ),
          BarItem(
            icon: Icons.event_note_sharp,
            title: 'Plans',
          ),
        ],
      ),
    );
  }

  void setselected(int index){
      selectedIndex = index;
  }

}

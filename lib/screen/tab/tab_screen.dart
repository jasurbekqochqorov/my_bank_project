import 'package:flutter/material.dart';
import 'package:my_bank_project/screen/tab/card/card_screen.dart';
import 'package:my_bank_project/screen/tab/profile/profile_screen.dart';

import '../../utils/colors/app_colors.dart';
import 'history/history_screen.dart';
import 'home/home_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int activeIndex = 0;
  List<Widget> screens = [const HomeScreen(), const CardScreen(),const HistoryScreen(),const ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[activeIndex],
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: AppColors.black,
        currentIndex: activeIndex,
        backgroundColor: AppColors.white,
        onTap: (index) {
          setState(() {
            activeIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.c_1317DD,
        unselectedItemColor: AppColors.c_1317DD.withOpacity(0.3),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,size:30,),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card,size:30,),
            label: "Card",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history,size:30,),
            label: "History",
          ),BottomNavigationBarItem(
            icon: Icon(Icons.person,size:30,),
            label: "Profile",
          )
        ],
      ),
    );
  }
}

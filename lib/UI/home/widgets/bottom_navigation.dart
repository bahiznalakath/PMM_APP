
import 'package:flutter/material.dart';
import 'package:personal_money_management_app/UI/home/screens_home.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext ctx, int updated, Widget?_) {
        return BottomNavigationBar(
          selectedItemColor: Colors.pink,
          currentIndex: updated,
          onTap: (newIndex) {
            ScreenHome.selectedIndexNotifier.value = newIndex;
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Translation'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Category'),
          ],
        );
      },

    );
  }
}

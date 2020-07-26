import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mangamint/constants/base_color.dart';
import 'package:mangamint/screens/home_screens/home_screen.dart';
import 'package:mangamint/screens/lainnya_screen/lainnya_screen.dart';
import 'package:mangamint/screens/list_manga_screen/index_manga_list.dart';
import 'package:mangamint/screens/tersimpan_screen/tersimpan_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> _children = [
    HomeScreen(),
    indexMangaLIst(),
    TersimpanScreen(),
    LainnyaScreen()
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[index],
      bottomNavigationBar: FFNavigationBar(
        selectedIndex: index,
        onSelectTab: _onTapTapped,
        theme: FFNavigationBarTheme(
            barBackgroundColor: BaseColor.red,
            selectedItemBackgroundColor: BaseColor.green,
            selectedItemIconColor: Colors.white,
            selectedItemLabelColor: BaseColor.black,
            unselectedItemIconColor: BaseColor.grey2,
            unselectedItemLabelColor: BaseColor.grey2),
        items: [
          FFNavigationBarItem(
            iconData: Icons.home,
            label: 'Home',
          ),
          FFNavigationBarItem(
            iconData: Icons.list,
            label: 'Daftar',
          ),
          FFNavigationBarItem(
            iconData: Icons.bookmark,
            label: 'Tersimpan',
          ),
          FFNavigationBarItem(
            iconData: Icons.more_horiz,
            label: 'Lainnya',
          ),
        ],
      ),
    );
  }

  void _onTapTapped(value) {
    setState(() {
      index = value;
    });
  }
}

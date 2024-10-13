// ignore_for_file: unused_field

import 'package:ecommerce_app1/presentation/Home/home_screen.dart';
import 'package:ecommerce_app1/presentation/Page/favorite_page.dart';
import 'package:ecommerce_app1/presentation/Page/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationPage extends ConsumerStatefulWidget {
  const BottomNavigationPage({super.key});
  static const String id = 'bottom';
  @override
  ConsumerState<BottomNavigationPage> createState() =>
      _BottomNavigationPageState();
}

class _BottomNavigationPageState extends ConsumerState<BottomNavigationPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const FavoritePage(),
    const SettingPage(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final favoriteCount = ref.watch(favoriteProductProviders);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Favorite',
            icon: Icon(
              Icons.favorite,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Setting',
            icon: Icon(
              Icons.settings,
            ),
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.tertiary,
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}

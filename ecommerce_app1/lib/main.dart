import 'package:ecommerce_app1/presentation/Home/home_screen.dart';
import 'package:ecommerce_app1/presentation/Page/bottom_navigation_page.dart';
import 'package:ecommerce_app1/presentation/Page/favorite_page.dart';
import 'package:ecommerce_app1/presentation/Page/setting_page.dart';
import 'package:ecommerce_app1/presentation/Page/welcom_page.dart';
import 'package:ecommerce_app1/providers/dark_light.dart';
import 'package:ecommerce_app1/utils/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settingsBox');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thems = ref.watch(themeProvider);
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: thems.currentTheme,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        BottomNavigationPage.id: (context) => const BottomNavigationPage(),
        HomeScreen.id: (context) => const HomeScreen(),
        FavoritePage.id: (context) => const FavoritePage(),
        SettingPage.id: (context) => const SettingPage(),
      },
    );
  }
}

import 'package:ecommerce_app1/providers/dark_light.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DarkandLIighBotton extends StatelessWidget {
  const DarkandLIighBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, snapshot, child) {
      final themeModel = snapshot.watch(themeProvider);
      return IconButton(
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return RotationTransition(
              turns: child.key == const ValueKey('light')
                  ? Tween<double>(begin: 1.0, end: 0.75).animate(animation)
                  : Tween<double>(begin: 0.75, end: 1.0).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: themeModel.isDarkMode
              ? Icon(
                  Icons.dark_mode,
                  key: const ValueKey('dark'),
                  color: Theme.of(context).colorScheme.onSecondary,
                )
              : Icon(
                  Icons.light_mode,
                  key: const ValueKey('light'),
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
        ),
        onPressed: () {
          snapshot.read(themeProvider).toggleTheme();
        },
      );
    });
  }
}

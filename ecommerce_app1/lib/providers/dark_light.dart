import 'package:ecommerce_app1/utils/main_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = ChangeNotifierProvider<ThemeModel>((ref) {
  return ThemeModel();
});

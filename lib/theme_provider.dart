import 'package:flutter/material.dart';
import 'package:musicplayer/dark_mode.dart';
import 'package:musicplayer/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // تیم در اول باید چه باشد در اینجا مشخص میشود
  ThemeData _themeData = lightMode;
  // بخاطر گرفتن معلومات فعلی یگ گیتر میسازیم
  ThemeData get themeData => _themeData;
  //  در اینجا میخواهیم بدانیم که تیم ما دارک است یا لایت
  bool get isDarkMode => _themeData == dartMode;
  // در اینجا باید یک سیتر بخاطر تغییر تیم
  set setThemeData(ThemeData themedata) {
    _themeData = themeData;
    notifyListeners();
  }

  // برای تغییر تیم یک فنکشن میسازیم
  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = dartMode;
      notifyListeners();
    } else {
      _themeData = lightMode;
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:musicplayer/light_mode.dart';
import 'package:musicplayer/pages/home_page.dart';
import 'package:musicplayer/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: homePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

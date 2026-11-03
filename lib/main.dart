import 'package:flutter/material.dart';
import 'package:musicplayer/playlist-provider.dart';
import 'package:musicplayer/theme/light_mode.dart';
import 'package:musicplayer/pages/home_page.dart';
import 'package:musicplayer/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => PlaylistProvider()),
      ],
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

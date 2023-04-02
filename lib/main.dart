import 'package:flutter/material.dart';
import 'package:search_it/constants/constants.dart';

import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search It',
      home: const HomeScreen(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kScaffoldBackgroundColor,
        appBarTheme: const AppBarTheme(backgroundColor: kAppBarColor),
      ),
    );
  }
}

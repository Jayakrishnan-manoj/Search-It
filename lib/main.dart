import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:search_it/services/Auth/auth_service.dart';
import 'package:search_it/constants/constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search It',
      home: AuthService().handleAuthState(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kScaffoldBackgroundColor,
        appBarTheme: const AppBarTheme(backgroundColor: kAppBarColor),
      ),
      
    );
  }
}

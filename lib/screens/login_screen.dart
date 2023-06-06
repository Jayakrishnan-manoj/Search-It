import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_it/services/Auth/auth_service.dart';
import 'package:search_it/constants/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "SEARCH-IT",
              style: GoogleFonts.acme(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SignInButton(
            Buttons.Google,
            text: "Sign In with Google",
            onPressed: () {
              AuthService().signInWithGoogle();
            },
          )
        ],
      ),
    );
  }
}

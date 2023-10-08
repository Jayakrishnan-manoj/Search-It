import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_it/services/Auth/auth_service.dart';
import 'package:search_it/constants/constants.dart';
import 'package:search_it/widgets/login_button.dart';

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
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          LoginButton(
            image: "assets/images/google-frame.png",
            buttonTitle: "Sign In With Google",
            onPressed: () {
              AuthService().signInWithGoogle();
            },
          ),
        ],
      ),
    );
  }
}

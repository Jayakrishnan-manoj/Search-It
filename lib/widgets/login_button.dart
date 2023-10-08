import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String image;
  final String buttonTitle;
  final VoidCallback onPressed;
  const LoginButton({
    super.key,
    required this.image,
    required this.buttonTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 55,
        width: MediaQuery.sizeOf(context).width * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image),
            const SizedBox(
              width: 20,
            ),
            Text(
              buttonTitle,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

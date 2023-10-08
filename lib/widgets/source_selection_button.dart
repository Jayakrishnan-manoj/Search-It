import 'package:flutter/material.dart';

class SourceSelectionButton extends StatelessWidget {
  final Widget icon;
  final String buttonTitle;
  final VoidCallback onPressed;
  const SourceSelectionButton({
    super.key,
    required this.icon,
    required this.buttonTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65,
        width: MediaQuery.sizeOf(context).width * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: icon,
            ),
            Expanded(
              child: Text(
                buttonTitle,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

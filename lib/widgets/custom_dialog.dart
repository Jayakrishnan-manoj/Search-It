import 'package:flutter/material.dart';
import 'package:search_it/constants/constants.dart';

customDialog(BuildContext context, VoidCallback saveFunction) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: kScaffoldBackgroundColor,
        title: const Text(
          "Save API Key",
          textAlign: TextAlign.left,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.orange,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.orange,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kAppBarColor,
            ),
            child: const Text("CANCEL"),
          ),
          ElevatedButton(
            onPressed: saveFunction,
            style: ElevatedButton.styleFrom(
              backgroundColor: kAppBarColor,
            ),
            child: const Text("SAVE"),
          )
        ],
      );
    },
  );
}

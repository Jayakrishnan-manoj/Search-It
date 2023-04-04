import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:search_it/constants/constants.dart';
import 'package:search_it/models/chat_message_model.dart';

class ChatMessageWidget extends StatelessWidget {
  final String text;
  final ChatMessageType messageType;
  const ChatMessageWidget(
      {super.key, required this.text, required this.messageType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: messageType == ChatMessageType.user
              ? kAppBarColor
              : kScaffoldBackgroundColor,
        ),
        height: MediaQuery.of(context).size.height * 0.15,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            top: 8.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              messageType == ChatMessageType.bot
                  ? Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: const CircleAvatar(
                        backgroundColor: kScaffoldBackgroundColor,
                        child: Icon(Icons.rocket),
                      ),
                    )
                  : Container(
                      color: kAppBarColor,
                      margin: const EdgeInsets.only(right: 15),
                      child: const CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        text,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

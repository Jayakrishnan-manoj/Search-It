import 'package:flutter/material.dart';
import 'package:search_it/constants/constants.dart';
import 'package:search_it/models/chat_message_model.dart';

class ChatMessageWidget extends StatelessWidget {
  final String text;
  final ChatMessageType messageType;
  const ChatMessageWidget({
    super.key,
    required this.text,
    required this.messageType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: messageType == ChatMessageType.user
              ? Colors.white70
              : kScaffoldBackgroundColor,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.sizeOf(context).width * 0.04,
            top: 8.0,
            bottom: MediaQuery.sizeOf(context).height * 0.03,
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
                      margin: const EdgeInsets.only(right: 15),
                      child: const CircleAvatar(
                        backgroundColor: kScaffoldBackgroundColor,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    text,
                    softWrap: true,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

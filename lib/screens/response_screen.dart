import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:search_it/constants/constants.dart';

import '../models/chat_message_model.dart';
import '../widgets/chat_message.dart';
import '../openAi/functions.dart';

class ResponseScreen extends StatefulWidget {
  String? response;

  ResponseScreen({super.key, required this.response});

  @override
  State<ResponseScreen> createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> {
  bool _isLoading = false;
  String? result;
  final _scrollController = ScrollController();
  final List<ChatMessage> _message = [];
  TextEditingController _inputController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getResponse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversation"),
      ),
      body: _isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ChatMessageWidget(
                          text: widget.response!,
                          messageType: ChatMessageType.bot,
                        ),
                        Expanded(
                          child: _buildList(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _inputController,
                          textCapitalization: TextCapitalization.sentences,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            fillColor: kAppBarColor,
                            border: InputBorder.none,
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _message.add(
                              ChatMessage(
                                text: _inputController.text,
                                chatMessageType: ChatMessageType.user,
                              ),
                            );
                          });
                          var input = _inputController.text;
                          _inputController.clear();
                          Future.delayed(
                            const Duration(milliseconds: 50),
                          ).then((value) {
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          });
                          generateResponse(input).then((value) {
                            setState(() {
                              _message.add(
                                ChatMessage(
                                  text: value,
                                  chatMessageType: ChatMessageType.bot,
                                ),
                              );
                            });
                          });
                          _inputController.clear();
                          Future.delayed(
                            const Duration(milliseconds: 50),
                          ).then((value) {
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          });
                        },
                        child: Center(
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(30)),
                            child: const Icon(
                              Icons.send,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     regenerateResponse();
                  //   },
                  //   child: const Text("Regenerate Response"),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: kAppBarColor,
                  //   ),
                  // ),
                ],
              ),
            ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      itemCount: _message.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        var message = _message[index];
        return ChatMessageWidget(
          text: message.text,
          messageType: message.chatMessageType,
        );
      },
    );
  }

  Future<void> getResponse() async {
    setState(() {
      _isLoading = true;
    });
    final String output = await generateResponse(widget.response!);

    setState(() {
      result = output;
      _isLoading = false;
    });
  }

  Future<void> regenerateResponse() async {
    setState(() {
      _isLoading = true;
    });
    final String output = await generateResponse("${widget.response!} explain");

    setState(() {
      result = output;
      _isLoading = false;
    });
  }
}

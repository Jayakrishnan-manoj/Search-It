import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:search_it/models/chat_message_model.dart';
import 'package:search_it/widgets/chat_message.dart';

import '../constants/constants.dart';
import '../openAi/functions.dart';
import '../utils/image_crop_page.dart';
import '../utils/image_picker.dart';
import 'image_screen.dart';

class ResponseScreen extends StatefulWidget {
  String response;
  ResponseScreen({super.key, required this.response});

  @override
  State<ResponseScreen> createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen>
    with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;
  bool _isLoading = true;
  String? result;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    final curvedAnimation = CurvedAnimation(
        parent: _animationController!, curve: Curves.easeInCubic);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();

    getResponse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Response"),
      ),
      floatingActionButton: FloatingActionBubble(
        items: [
          Bubble(
            icon: Icons.photo,
            iconColor: Colors.white,
            title: "Add An Image",
            titleStyle: const TextStyle(fontSize: 20, color: Colors.white),
            bubbleColor: kAppBarColor,
            onPress: () {
              pickImage(source: ImageSource.gallery).then((value) {
                if (value != '') {
                  imageCropperView(value, context).then((value) {
                    if (value != '') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageScreen(path: value),
                        ),
                      );
                    }
                  });
                }
              });
            },
          ),
          Bubble(
            icon: Icons.camera,
            iconColor: Colors.white,
            title: "Open Camera",
            titleStyle: const TextStyle(fontSize: 20, color: Colors.white),
            bubbleColor: kAppBarColor,
            onPress: () {
              pickImage(source: ImageSource.camera).then((value) {
                if (value != '') {
                  imageCropperView(value, context).then((value) {
                    if (value != '') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageScreen(path: value),
                        ),
                      );
                    }
                  });
                }
              });
            },
          ),
        ],
        onPress: () => _animationController!.isCompleted
            ? _animationController!.reverse()
            : _animationController!.forward(),
        iconColor: Colors.white,
        backGroundColor: Colors.orange,
        animation: _animation!,
        iconData: Icons.add,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: _isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            )
          : Column(
              children: [
                ChatMessageWidget(
                  text: widget.response,
                  messageType: ChatMessageType.user,
                ),
                ChatMessageWidget(
                  text: result!,
                  messageType: ChatMessageType.bot,
                ),
              ],
            ),
    );
  }

  Future<void> getResponse() async {
    setState(() {
      _isLoading = true;
    });
    final String output = await generateResponse(widget.response);

    setState(() {
      result = output;

      _isLoading = false;
    });
  }
}

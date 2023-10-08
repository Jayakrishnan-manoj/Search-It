import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:search_it/models/chat_message_model.dart';
import 'package:search_it/widgets/chat_message.dart';

import '../constants/constants.dart';
import '../services/api_service.dart';
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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            kScaffoldBackgroundColor,
            Color(0xFF016b93),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Response"),
        ),
        bottomNavigationBar: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.06,
          child: ElevatedButton(
            onPressed: () {
              getResponse();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kScaffoldBackgroundColor,
            ),
            child: const Text(
              "REGENERATE RESPONSE",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionBubble(
          items: [
            Bubble(
              icon: Icons.photo,
              iconColor: kScaffoldBackgroundColor,
              title: "Add An Image",
              titleStyle: const TextStyle(
                  fontSize: 16, color: kScaffoldBackgroundColor),
              bubbleColor: Colors.white,
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
              iconColor: kScaffoldBackgroundColor,
              title: "Open Camera",
              titleStyle: const TextStyle(
                fontSize: 16,
                color: kScaffoldBackgroundColor,
              ),
              bubbleColor: Colors.white,
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
          iconColor: kScaffoldBackgroundColor,
          backGroundColor: Colors.white,
          animation: _animation!,
          iconData: Icons.add,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: _isLoading == true
            ? const Center(
                child: SpinKitFadingCircle(
                  color: Colors.white,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ChatMessageWidget(
                        text: widget.response,
                        messageType: ChatMessageType.user,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15,
                        ),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.fromLTRB(
                            10,
                            0,
                            10,
                            10,
                          ),
                          child: Text(
                            result!,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
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

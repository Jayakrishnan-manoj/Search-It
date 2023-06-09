import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:search_it/constants/constants.dart';
import 'package:search_it/screens/response_screen.dart';

class ImageScreen extends StatefulWidget {
  String? path;
  ImageScreen({super.key, required this.path});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  bool _isLoading = false;
  TextEditingController controller = TextEditingController();
  late File _imageFile;
  @override
  void initState() {
    super.initState();
    _imageFile = File(widget.path!);
    final InputImage inputImage = InputImage.fromFilePath(widget.path!);
    processImage(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search It'),
      ),
      body: _isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    width: double.infinity,
                    child: Image.file(
                      _imageFile,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: kAppBarColor,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          maxLines: null,
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: "Extracted Text",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 45.0,
                      bottom: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.05,
                          width: MediaQuery.sizeOf(context).width * 0.45,
                          child: ElevatedButton(
                            onPressed: () {
                              //customDialog(context);
                              // print(controller.text);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         ConversationScreen(response: controller.text),
                              //   ),
                              // );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kAppBarColor,
                            ),
                            child: const Text("Start Conversation"),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.05,
                          width: MediaQuery.sizeOf(context).width * 0.45,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ResponseScreen(response: controller.text),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kAppBarColor,
                            ),
                            child: const Text("Get Response"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    setState(() {
      _isLoading = true;
    });
    final RecognizedText recognizedText =
        await textRecognizer.processImage(image);
    controller.text = recognizedText.text;
    setState(() {
      _isLoading = false;
    });
  }
}

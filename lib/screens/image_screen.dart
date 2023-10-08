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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 20,
                          right: 20,
                          bottom: 10,
                        ),
                        width: double.infinity,
                        child: Image.file(
                          _imageFile,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.white70,
                        child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              style: const TextStyle(
                                color: Colors.black,
                              ),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResponseScreen(
                                        response: controller.text),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white70,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text(
                                "Get Response",
                                style: TextStyle(
                                  color: kScaffoldBackgroundColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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

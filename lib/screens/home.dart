import 'package:flutter/material.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:image_picker/image_picker.dart';
import 'package:search_it/constants/constants.dart';
import 'package:search_it/screens/image_screen.dart';
import 'package:search_it/utils/image_crop_page.dart';
import 'package:search_it/utils/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search It"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
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
              child: Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.photo),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Add an Image"),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
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
              child: Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.camera),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Open Camera"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionBubble(
        items: [
          Bubble(
            icon: Icons.coffee_maker,
            iconColor: Colors.white,
            title: "Buy me a Coffee",
            titleStyle: const TextStyle(fontSize: 20, color: Colors.white),
            bubbleColor: kAppBarColor,
            onPress: () => launchCoffee(),
          ),
        ],
        onPress: () => _animationController!.isCompleted
            ? _animationController!.reverse()
            : _animationController!.forward(),
        iconColor: Colors.white,
        backGroundColor: Colors.orange,
        animation: _animation!,
        iconData: Icons.coffee,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void launchCoffee() async {
    print("pressed");
    String url = "https://www.buymeacoffee.com/jayk05";
    var urlLaunchble = await launchUrl(
      Uri.parse(url),
    );
    if (urlLaunchble) {
      await launchUrl(
        Uri.parse(url),
      );
    }
  }
}

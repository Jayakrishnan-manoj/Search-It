import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_it/services/Auth/auth_service.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:image_picker/image_picker.dart';
import 'package:search_it/constants/constants.dart';
import 'package:search_it/screens/image_screen.dart';
import 'package:search_it/utils/image_crop_page.dart';
import 'package:search_it/utils/image_picker.dart';
import 'package:search_it/widgets/source_selection_button.dart';
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
          title: Text(
            "Search-It",
            style: GoogleFonts.acme(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => AuthService().signOut(),
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
                size: 35,
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SourceSelectionButton(
                icon: const Icon(
                  Icons.photo_library_outlined,
                  color: kScaffoldBackgroundColor,
                ),
                buttonTitle: "CHOOSE FROM GALLERY",
                onPressed: () {
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
              const SizedBox(
                height: 30,
              ),
              SourceSelectionButton(
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  color: kScaffoldBackgroundColor,
                ),
                buttonTitle: "OPEN CAMERA",
                onPressed: () {
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
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionBubble(
          items: [
            Bubble(
              icon: Icons.coffee_maker_outlined,
              iconColor: kScaffoldBackgroundColor,
              title: "Buy me a Coffee",
              titleStyle: const TextStyle(
                fontSize: 16,
                color: kScaffoldBackgroundColor,
                fontWeight: FontWeight.w500,
              ),
              bubbleColor: Colors.white,
              onPress: () => launchCoffee(),
            ),
          ],
          onPress: () => _animationController!.isCompleted
              ? _animationController!.reverse()
              : _animationController!.forward(),
          iconColor: kScaffoldBackgroundColor,
          backGroundColor: Colors.white,
          animation: _animation!,
          iconData: Icons.coffee,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
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

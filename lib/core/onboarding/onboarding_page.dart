import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/core/theme/colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    super.key,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  // _storeOnBoarding() async {
  //   await SharedPrefHelper.putInt(SharedPrefHelper.utils.onBoard, 1);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: const [
              CreatePage(
                image: 'assets/images/jpg/onboard-1nn.jpg',
                title: "Welcome to Hejaz E Moqaddus",
                subtitle:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean bibendum lobortis dictum.",
                color: themewhitecolor,
              ),
              CreatePage(
                image: 'assets/images/jpg/onboard-2nn.jpg',
                title: "Welcome to Hejaz E Moqaddus",
                subtitle:
                    "Etiam feugiat interdum nunc sed dignissim. Quisque elementum ligula ac sagittis gravida.",
                color: themewhitecolor,
              ),
              // CreatePage(
              //   image: 'assets/images/jpg/onboard-2n.jpg',
              //   title: "Flexible Payment Options",
              //   subtitle:
              //       "Curabitur porttitor velit nisi, vitae dictum ligula iaculis vitae.",
              //   color: themewhitecolor,
              // ),
            ],
          ),
          // Positioned(
          //   bottom: 135,
          //   child: Row(
          //     children: _buildIndicator(),
          //   ),
          // ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Go.onNamedReplace(
                  context,
                  RouteName.loginPage,
                );
              },
              child: FadeInUp(
                child: AnimatedContainer(
                  height: 55,
                  width: 140,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Palette.themecolor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  duration: const Duration(milliseconds: 500),
                  child: const Center(
                    child: Text(
                      "Let's Go",
                      style: TextStyle(
                        color: themewhitecolor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _activeindicator(bool isActive) {
  //   return AnimatedContainer(
  //     duration: const Duration(milliseconds: 300),
  //     height: 10.0,
  //     width: isActive ? 20 : 8,
  //     margin: const EdgeInsets.only(right: 5.0),
  //     decoration: BoxDecoration(
  //       color: Palette.themecolor,
  //       borderRadius: BorderRadius.circular(5),
  //     ),
  //   );
  // }

  // Widget _inactiveindicator(bool isInActive) {
  //   return AnimatedContainer(
  //     duration: const Duration(milliseconds: 300),
  //     height: 10.0,
  //     width: isInActive ? 20 : 8,
  //     margin: const EdgeInsets.only(right: 5.0),
  //     decoration: BoxDecoration(
  //       color: themegreycolor,
  //       borderRadius: BorderRadius.circular(5),
  //     ),
  //   );
  // }

  // List<Widget> _buildIndicator() {
  //   List<Widget> indicators = [];

  //   for (int i = 0; i < 2; i++) {
  //     if (currentIndex == i) {
  //       indicators.add(_activeindicator(true));
  //     } else {
  //       indicators.add(_inactiveindicator(false));
  //     }
  //   }
  //   return indicators;
  // }
}

class CreatePage extends StatelessWidget {
  final String image;
  final String title;
  final Color color;
  final String subtitle;
  const CreatePage({
    super.key,
    required this.image,
    required this.title,
    required this.color,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              themeblackcolor.withOpacity(0.1),
              themeblackcolor.withOpacity(0.3),
              themeblackcolor.withOpacity(0.5),
              themeblackcolor.withOpacity(0.7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Text(
                title,
                style: context.textTheme.headlineLarge
                    ?.copyWith(color: color)
                    .bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 110),
              child: Text(
                subtitle,
                style:
                    context.textTheme.bodyMedium?.copyWith(color: color).w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

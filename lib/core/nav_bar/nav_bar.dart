import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/features/chat/views/pages/chat_page.dart';
import 'package:sis/features/home/views/pages/home_page.dart';
import 'package:sis/features/profile/views/pages/profile_page.dart';
import 'package:sis/features/projects/views/pages/projects_page.dart';
import 'package:sis/features/tasks/views/pages/tasks_page.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;
  const NavBar({super.key, required this.currentIndex});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });

    _pageController.jumpToPage(index);

    switch (index) {
      case 0:
        Go.namedReplace(
          context,
          RouteName.homePage,
        );
        break;
      case 1:
        Go.namedReplace(
          context,
          RouteName.projectsPage,
        );
        break;
      case 2:
        Go.namedReplace(
          context,
          RouteName.tasksPage,
        );
        break;
      case 3:
        Go.namedReplace(
          context,
          RouteName.chatPage,
        );
        break;
      case 4:
        Go.namedReplace(
          context,
          RouteName.profilePage,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomePage(),
          ProjectsPage(),
          TasksPage(),
          ChatPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 50,
          right: 50,
          bottom: 8,
        ),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: context.colorScheme.secondary.withOpacity(0.35),
            borderRadius: BorderRadius.circular(60),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              5,
              (index) => GestureDetector(
                onTap: () {
                  _onPageChanged(index);
                },
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: _currentIndex == index
                      ? context.colorScheme.primary
                      : context.colorScheme.secondary,
                  child: Icon(
                    index == 0
                        ? CupertinoIcons.home
                        : index == 1
                            ? CupertinoIcons.search
                            : index == 2
                                ? CupertinoIcons.calendar
                                : index == 3
                                    ? CupertinoIcons.bubble_left
                                    : CupertinoIcons.person,
                    color: _currentIndex == index
                        ? context.colorScheme.secondary
                        : context.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

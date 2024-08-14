import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/variables/global_variables.dart';
import 'package:instagram/widgets/side_navbar.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: width > webScreenSize
          ? Row(
              children: [
                const Expanded(flex: 2, child: SideNavbar()),
                const VerticalDivider(),
                Expanded(
                  flex: 7,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    onPageChanged: onPageChanged,
                    children: homeScreenItems,
                  ),
                ),
                const VerticalDivider(),
                Container(
                    child: width > webScreenSize * 2
                        ? Expanded(flex: 3, child: Text("Suggestions"))
                        : null),
              ],
            )
          : PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: onPageChanged,
              children: homeScreenItems,
            ),
      bottomNavigationBar: width > webScreenSize
          ? null
          : BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: _page == 0 ? blackColour : greyColor,
                  ),
                  // backgroundColor: mobileBackgroundColor,
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: _page == 1 ? blackColour : greyColor,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: _page == 2 ? blackColour : greyColor,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    color: _page == 3 ? blackColour : greyColor,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: _page == 4 ? blackColour : greyColor,
                  ),
                  label: "",
                ),
              ],
              onTap: navigationTapped,
            ),
    );
  }
}

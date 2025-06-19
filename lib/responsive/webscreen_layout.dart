import 'package:flutter/material.dart';
import 'package:instagram/variables/global_variables.dart';
import 'package:instagram/widgets/side_navbar.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;

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
                  child: homeScreenItems[_page],
                ),
                const VerticalDivider(),
                Container(
                    child: width > webScreenSize * 2
                        ? Expanded(flex: 3, child: Text("Suggestions"))
                        : null),
              ],
            )
          : homeScreenItems[_page],
      bottomNavigationBar: width > webScreenSize
          ? null
          : BottomNavigationBar(
              currentIndex: _page,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                setState(() {
                  _page = value;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.home),
                  icon: Icon(
                    Icons.home_outlined,
                  ),
                  label: "home",
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.search),
                  icon: Icon(
                    Icons.search_rounded,
                  ),
                  label: "search",
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.add),
                  icon: Icon(
                    Icons.add_circle_outline,
                  ),
                  label: "create",
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.favorite),
                  icon: Icon(
                    Icons.favorite_outline,
                  ),
                  label: "chat",
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.person),
                  icon: Icon(
                    Icons.person_outline,
                  ),
                  label: "profile",
                ),
              ],
            ),
    );
  }
}

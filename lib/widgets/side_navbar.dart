import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/utils/colors.dart';

class SideNavbar extends StatelessWidget {
  const SideNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: double.infinity,
      color: primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              child: SvgPicture.asset(
                "ic_instagram.svg",
                width: 80,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sideBarItems(Icons.home, 'Home'),
              sideBarItems(Icons.search, 'Search'),
              sideBarItems(Icons.explore_outlined, 'Explore'),
              sideBarItems(Icons.play_circle_outline_sharp, 'Reels'),
              sideBarItems(Icons.message_outlined, 'Messages'),
              sideBarItems(Icons.favorite_outline, 'Notifications'),
              sideBarItems(Icons.add_box_outlined, 'Create'),
              sideBarItems(Icons.person, 'Profile'),
            ],
          ),
        ],
      ),
    );
  }

  Widget sideBarItems(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          width: 150,
          child: Row(
            children: [
              Icon(
                icon,
                size: 28,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/screens/messages.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/variables/global_variables.dart';
import 'package:instagram/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width < webScreenSize
          ? AppBar(
              backgroundColor: primaryColor,
              centerTitle: false,
              title: SvgPicture.asset(
                'ic_instagram.svg',
                color: blackColour,
                height: 32,
              ),
              actions: [
                IconButton(
                  color: blackColour,
                  tooltip: 'Open Notifications',
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
                IconButton(
                  color: blackColour,
                  tooltip: 'Open Messages',
                  icon: const Icon(Icons.message_outlined),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Messages()));
                  },
                )
              ],
              elevation: 8,
            )
          : null,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: 500,
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) => PostCard(
                    snap: snapshot.data!.docs[index],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

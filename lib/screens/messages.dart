import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/widgets/textfield_inputs.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  String userName = "";
  @override
  void initState() {
    super.initState();
    getUserName();
  }

  void getUserName() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      userName = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("$userName"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                size: 25,
              ))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFieldInputs(
                hintText: 'Search',
                textEditingController: _searchController,
                textInputKeyBoardType: TextInputType.emailAddress),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  StatusIndicator(),
                  StatusIndicator(),
                  StatusIndicator(),
                  StatusIndicator(),
                  StatusIndicator(),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Messages",
                  style: TextStyle(fontSize: 18),
                ),
                GestureDetector(
                  child: Text(
                    "Requests",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                  ),
                )
              ],
            ),
            //CHATS SECTION
            const SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Chats(),
                  Chats(),
                  Chats(),
                  Chats(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Chats extends StatelessWidget {
  const Chats({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Card(
        elevation: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blueAccent,
            ),
            const Column(
              children: [
                Text("Username"),
                Text("Messages"),
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(size: 60, Icons.camera_alt_outlined))
          ],
        ),
      ),
    );
  }
}

class StatusIndicator extends StatelessWidget {
  const StatusIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: Colors.red,
            radius: 40,
          ),
          Positioned(
              bottom: -2,
              left: 50,
              child: Icon(
                Icons.donut_small_rounded,
                color: Colors.lightGreen,
              ))
        ],
      ),
    );
  }
}

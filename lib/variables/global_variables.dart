import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screens/addpost.dart';
import 'package:instagram/screens/feedScreen.dart';
import 'package:instagram/screens/search_tab.dart';
import 'package:instagram/screens/user_profile.dart';

const webScreenSize = 500;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchTab(),
  const AddPostScreen(),
  const Text("notify"),
  UserProfile(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];

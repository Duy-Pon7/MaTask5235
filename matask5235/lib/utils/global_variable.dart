import 'package:flutter/material.dart';
import 'package:matask5235/views/screens/feed_screen.dart';
import 'package:matask5235/views/screens/profile_screen.dart';
import 'package:matask5235/views/screens/search_screen.dart';
import 'package:matask5235/views/screens/wishlist_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  SearchScreen(),
  WishlistScreen(),
  const ProfileScreen(),
];

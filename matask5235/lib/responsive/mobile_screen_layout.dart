import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:matask5235/utils/colors.dart';
import 'package:matask5235/utils/global_variable.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() =>
      _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout>
    with SingleTickerProviderStateMixin {
  int _page = 0;
  late PageController pageController; // for tabs animation

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

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    // Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                _page == 0 ? Iconsax.home : Iconsax.home,
                color: _page == 0 ? primary600 : neutral300,
              ),
              onPressed: () => navigationTapped(0),
            ),
            IconButton(
              icon: Icon(
                _page == 1
                    ? Iconsax.search_normal
                    : Iconsax.search_normal,
                color: _page == 1 ? primary600 : neutral300,
              ),
              onPressed: () => navigationTapped(1),
            ),
            const SizedBox(width: 40), // khoảng trống cho nút giữa
            IconButton(
              icon: Icon(
                _page == 2 ? Iconsax.bookmark : Iconsax.bookmark,
                color: _page == 2 ? primary600 : neutral300,
              ),
              onPressed: () => navigationTapped(2),
            ),
            IconButton(
              icon: Icon(
                _page == 3 ? Iconsax.user : Iconsax.user,
                color: _page == 3 ? primary600 : neutral300,
              ),
              onPressed: () => navigationTapped(3),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [primary500, primary600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FloatingActionButton(
          onPressed: () {
            // Hành động khi nhấn nút giữa
          },
          backgroundColor:
              Colors.transparent, // Đặt màu nền trong suốt
          elevation: 0, // Loại bỏ bóng
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
    );
  }
}

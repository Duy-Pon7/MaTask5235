import 'package:flutter/material.dart';
import 'package:matask5235/responsive/mobile_screen_layout.dart';
import 'package:matask5235/responsive/responsive_layout.dart';
import 'package:matask5235/responsive/web_screen_layout.dart';
import 'package:matask5235/utils/colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/onboarding_background.jpg',
                  ),
                  fit:
                      BoxFit
                          .cover, // Đảm bảo ảnh bao phủ toàn bộ màn hình
                ),
              ),
            ),
          ),
          // Content overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(
                0.5,
              ), // Lớp phủ màu đen mờ
            ),
          ),
          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 41.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    "Bắt đầu với những món ăn",
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => const ResponsiveLayout(
                                mobileScreenLayout:
                                    MobileScreenLayout(),
                                webScreenLayout: WebScreenLayout(),
                              ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary600, // Màu nền nút
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "Bắt đầu",
                          style: TextStyle(
                            color: Colors.black, // Màu chữ
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.black, // Màu icon
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

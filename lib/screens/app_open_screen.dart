import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppOpenScreen extends StatelessWidget {
  const AppOpenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(34),
              child: Image.asset(
                'assets/images/bkash_app_icon.png',
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, '/splash'),
              child: const Text(
                'Click To Open bKash App',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: kPink,
                  decoration: TextDecoration.underline,
                  decorationColor: kPink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
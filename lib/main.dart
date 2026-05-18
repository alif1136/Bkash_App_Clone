import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'screens/app_open_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const BkashApp(),
    ),
  );
}

class BkashApp extends StatelessWidget {
  const BkashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bKash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE2136E)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/':        (_) => const AppOpenScreen(),
        '/splash':  (_) => const SplashScreen(),
        '/home':    (_) => const HomeScreen(),
        '/menu':    (_) => const MenuScreen(),
        '/profile': (_) => const ProfileScreen(),
      },
    );
  }
}
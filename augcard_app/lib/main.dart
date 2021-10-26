import 'package:augcard_app/pages/enter_code_page.dart';
import 'package:augcard_app/pages/login_page.dart';
import 'package:augcard_app/pages/start_screen_page.dart';
import 'package:augcard_app/pages/user_joined_page.dart';
import 'package:augcard_app/styles/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Augmented Card Game',
      theme: AugCardTheme.lightTheme,
      darkTheme: AugCardTheme.darkTheme,
      // themeMode: ThemeMode.dark,
      routes: {
        StartScreenPage.routeName: (ctx) => const StartScreenPage(),
        LoginPage.routeName: (ctx) => const LoginPage(),
        EnterCodePage.routeName: (ctx) => const EnterCodePage(),
        UserJoinedPage.routeName: (ctx) => const UserJoinedPage(),
      },
    );
  }
}

import 'package:augcard_app/pages/enter_code_page.dart';
import 'package:augcard_app/pages/login_page.dart';
import 'package:augcard_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class StartScreenPage extends StatelessWidget {
  static const routeName = '/';
  const StartScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Augmented Card Game',
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  PrimaryButton.text(
                      text: 'Sign in',
                      onPressed: () =>
                          Navigator.of(context).pushNamed(LoginPage.routeName)),
                  const SizedBox(
                    height: 8,
                  ),
                  PrimaryButton.text(
                      text: 'Join Game',
                      onPressed: () => Navigator.of(context)
                          .pushNamed(EnterCodePage.routeName))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

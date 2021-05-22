import 'package:chat_me/components/CustomButton.dart';
import 'package:chat_me/screens/login_screen.dart';
import 'package:chat_me/screens/register_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'logo',
              child: Image.asset(
                'images/logo.png',
                width: 200.0,
                height: 200.0,
              ),
            ),
            Padding(padding: EdgeInsets.all(20.0)),
            CustomButton(
              title: 'Register ',
              onPressed: () => Navigator.pushNamed(context, RegisterScreen.id),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            CustomButton(
              title: 'Log In ',
              onPressed: () => Navigator.pushNamed(context, LoginScreen.id),
            ),
          ],
        ),
      ),
    ));
  }
}

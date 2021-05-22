import 'package:chat_me/screens/chat_screen.dart';
import 'package:chat_me/screens/login_screen.dart';
import 'package:chat_me/screens/register_screen.dart';
import 'package:chat_me/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error);
        }

        if (snapshot.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: WelcomeScreen.id,
            routes: {
              WelcomeScreen.id: (context) => WelcomeScreen(),
              RegisterScreen.id: (context) => RegisterScreen(),
              LoginScreen.id: (context) => LoginScreen(),
              ChatScreen.id: (context) => ChatScreen(),
            },
          );
        }

        return Directionality(
          textDirection: TextDirection.ltr,
          child: Text('Loading'),
        );
      },
    );
  }
}

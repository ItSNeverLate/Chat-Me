import 'package:chat_me/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firebaseAuth = FirebaseAuth.instance;
  final _messageTextController = TextEditingController();
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Me'),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                try {
                  await _firebaseAuth.signOut();
                } catch (e) {} finally {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    WelcomeScreen.id,
                    (_) => false,
                  );
                }
              })
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                        controller: _messageTextController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                        onChanged: (value) => message = value),
                  ),
                  IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        print(message);
                        message = '';
                        _messageTextController.clear();
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

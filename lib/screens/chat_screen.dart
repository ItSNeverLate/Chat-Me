import 'package:chat_me/components/MessageBubble.dart';
import 'package:chat_me/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseStore = FirebaseFirestore.instance;
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
              child: StreamBuilder<QuerySnapshot>(
                  stream: _firebaseStore
                      .collection('messages')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            final message =
                                snapshot.data.docs[index]['message'];
                            final isMine = snapshot.data.docs[index]
                                    ['sender'] ==
                                _firebaseAuth.currentUser.email;
                            final timestamp =
                                snapshot.data.docs[index]['timestamp'];
                            return MessageBubble(
                              message: message,
                              timestamp: timestamp,
                              isMine: isMine,
                            );
                          });
                    }

                    return CupertinoActivityIndicator();
                  }),
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
                    color: Theme.of(context).primaryColor,
                    iconSize: 30.0,
                    onPressed: () async {
                      try {
                        CollectionReference messages =
                            _firebaseStore.collection('messages');
                        await messages.add({
                          'message': message.trim(),
                          'sender': _firebaseAuth.currentUser.email,
                          'timestamp': Timestamp.now()
                        });

                        message = '';
                        _messageTextController.clear();

                        QuerySnapshot snapshot = await messages.get();
                      } catch (e) {}
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

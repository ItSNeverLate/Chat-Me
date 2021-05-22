import 'package:chat_me/components/CustomButton.dart';
import 'package:chat_me/components/CustomTextField.dart';
import 'package:chat_me/screens/chat_screen.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _firebaseAuth = FirebaseAuth.instance;
  String email;
  String password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Existing User'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'images/logo.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(30.0)),
                CustomTextField(
                  hint: 'Email',
                  onChanged: (value) => email = value,
                  keyboardType: TextInputType.emailAddress,
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                CustomTextField(
                    hint: 'Password',
                    onChanged: (value) => password = value,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true),
                Padding(padding: EdgeInsets.all(20.0)),
                CustomButton(
                  title: 'Log In',
                  onPressed: () async {
                    setState(() => isLoading = true);

                    try {
                      final user =
                          await _firebaseAuth.signInWithEmailAndPassword(
                              email: email, password: password);
                      if (user != null) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          ChatScreen.id,
                          (_) => false,
                        );
                      }
                    } catch (e) {
                      CoolAlert.show(
                        confirmBtnColor: Theme.of(context).primaryColor,
                        context: context,
                        type: CoolAlertType.error,
                        title: 'Error',
                        text: 'Invalid username and/or password.',
                        loopAnimation: true,
                      );
                    } finally {
                      setState(() => isLoading = false);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

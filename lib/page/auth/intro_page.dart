import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/page/auth/register_or_login_page.dart';
import 'package:firebase_chat/page/chat/chat_list_page.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            return  ChatListPage();
          } else {
            return const  RegisterOrLoginPage();
          }
        },
      ),
    );
  }
}

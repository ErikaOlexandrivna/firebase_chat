import 'package:firebase_chat/firebase_options.dart';
import 'package:firebase_chat/page/auth/intro_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const ChatFirebase());
}

class ChatFirebase extends StatelessWidget {
  const ChatFirebase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const  IntroPage(),
    );
  }
}

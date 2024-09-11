import 'package:firebase_chat/page/login_page.dart';
import 'package:firebase_chat/page/register_page.dart';
import 'package:flutter/material.dart';

class RegisterOrLoginPage extends StatefulWidget {
  const RegisterOrLoginPage({super.key});

  @override
  State<RegisterOrLoginPage> createState() => _RegisterOrLoginPageState();
}

class _RegisterOrLoginPageState extends State<RegisterOrLoginPage> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 1200),
        transitionBuilder: (Widget child, Animation<double> animation) {
          const begin = 0.8;
          const end = 1.0;
          const curve = Curves.easeInOut;
          final scaleAnimation = Tween<double>(begin: begin, end: end)
              .animate(CurvedAnimation(parent: animation, curve: curve));

          return ScaleTransition(scale: scaleAnimation, child: child);
        },
        child: showLoginPage
            ? LoginPage(onTap: togglePages)
            : RegisterPage(onTap: togglePages),
      ),
    );
  }
}

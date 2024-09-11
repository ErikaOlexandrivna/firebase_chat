import 'package:firebase_chat/components/custom_text_field_component.dart';
import 'package:firebase_chat/page/chat/chat_list_page.dart';
import 'package:firebase_chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  final void Function() onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/animated/Aniki Hamster.json', height: 250),
                const SizedBox(height: 25),
                Text(
                  'Register'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 40,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                CustomTextFieldComponent(
                  controller: emailController,
                  label: 'Email',
                  icon: const Icon(Icons.email_outlined),
                  hintText: 'Edter your email',
                ),
                const SizedBox(height: 10),
                CustomTextFieldComponent(
                  controller: passwordController,
                  label: 'Password',
                  icon: const Icon(Icons.remove_red_eye),
                  hintText: 'Edter your password',
                ),
                const SizedBox(height: 10),
                CustomTextFieldComponent(
                  controller: repeatPasswordController,
                  label: 'Repeat Password',
                  icon: const Icon(Icons.remove_red_eye),
                  hintText: 'Enter your password',
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                    onPressed: () {
                      signUp(context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Sign Up'.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 19,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    )),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: widget.onTap,
                  child: const Text('Login now'),
                )
              ],
            )),
      ),
    );
  }

  void signUp({required BuildContext context}) async {
    if (passwordController.text != repeatPasswordController.text) {
      showError();
    } else {
      try {
        await _authService.signUpWithEmail(
            email: emailController.text, password: passwordController.text);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  ChatListPage()));
      } catch (error) {
        print('Regisre page, method signUp $error');
      }
    }
  }

  void showError() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Паролі не спвпадають')));
  }
}

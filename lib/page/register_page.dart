import 'package:firebase_chat/components/custom_text_field_component.dart';
import 'package:firebase_chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'chat/chat_list_page.dart';

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
  final TextEditingController repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLottieAnimation(),
            const SizedBox(height: 25),
            _buildTitle(),
            _buildCustomTextField(
              controller: emailController,
              label: 'Email',
              icon: Icons.email_outlined,
              hintText: 'Enter your email',
            ),
            const SizedBox(height: 10),
            _buildCustomTextField(
              controller: passwordController,
              label: 'Password',
              icon: Icons.remove_red_eye,
              hintText: 'Enter your password',
            ),
            const SizedBox(height: 10),
            _buildCustomTextField(
              controller: repeatPasswordController,
              label: 'Repeat Password  ',
              icon: Icons.remove_red_eye,
              hintText: 'Repeat your password',
            ),
            const SizedBox(height: 40),
            _buildSignUpButton(),
            const SizedBox(height: 20),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLottieAnimation() {
    return Lottie.asset('assets/animated/Aniki Hamster.json', height: 250);
  }

  Widget _buildTitle() {
    return Text(
      'Register'.toUpperCase(),
      style: const TextStyle(
        fontSize: 40,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: () => signUp(),
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
      ),
    );
  }

  Widget _buildLoginButton() {
    return TextButton(
      onPressed: widget.onTap,
      child: const Text('Login now'),
    );
  }

  void signUp() async {
    if (passwordController.text != repeatPasswordController.text) {
      showError('Passwords do not match');
    } else {
      try {
        await _authService.signUpWithEmail(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatListPage()));
      } catch (error) {
        showError('Signup failed');
      }
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

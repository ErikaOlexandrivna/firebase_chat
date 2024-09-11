import 'package:firebase_chat/components/custom_text_field_component.dart';
import 'package:firebase_chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_chat/components/action_button.dart';

class LoginPage extends StatefulWidget {
  final void Function() onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String errorMessage = '';

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
            const SizedBox(height: 25),
            _buildEmailTextField(),
            const SizedBox(height: 10),
            _buildPasswordTextField(),
            const SizedBox(height: 40),
            _buildErrorMessage(),
            const SizedBox(height: 20),
            ActionButton(
              text: 'Sign In',
              onPressed: () => singIn(),
              isSignInButton: true,
            ),
            const SizedBox(height: 20),
            _buildRegisterButton(),
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
      'Log In'.toUpperCase(),
      style: const TextStyle(
        fontSize: 40,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildEmailTextField() {
    return CustomTextFieldComponent(
      controller: emailController,
      label: 'Email',
      icon: const Icon(Icons.email_outlined),
      hintText: 'Enter your email',
    );
  }

  Widget _buildPasswordTextField() {
    return CustomTextFieldComponent(
      controller: passwordController,
      obscureText: true,
      label: 'Password',
      icon: const Icon(Icons.remove_red_eye),
      hintText: 'Enter your password',
    );
  }

  Widget _buildErrorMessage() {
    if (errorMessage.isNotEmpty) {
      return Text(
        errorMessage,
        style: const TextStyle(fontSize: 32),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildRegisterButton() {
    return TextButton(
      onPressed: widget.onTap,
      child: const Text('Register now'),
    );
  }

  void singIn() async {
    try {
      await _authService.signInWithEmail(
        email: emailController.text,
        password: passwordController.text,
      );
    } catch (error) {
      setState(() {
        print("Усвідомленний конфлікт");
        errorMessage = error.toString();
      });
    }
  }
}

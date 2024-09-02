import 'package:firebase_chat/components/custom_text_field_component.dart';
import 'package:firebase_chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
              Lottie.asset('assets/animated/Aniki Hamster.json', height: 250),
              const SizedBox(height: 25),
              Text(
                'Log In'.toUpperCase(),
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
                obscureText: true,
                label: 'Password',
                icon: const Icon(Icons.remove_red_eye),
                hintText: 'Edter your password',
              ),
              const SizedBox(height: 40),
              if (errorMessage != '')
                Text(
                  errorMessage,
                  style: const TextStyle(fontSize: 32),
                ),
              ElevatedButton(
                  onPressed: () => singIn(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Sign In'.toUpperCase(),
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
                child: const Text('Register now'),
              )
            ],
          )),
    );
  }

  void singIn() async {
    try {
      await _authService.signInWithEmail(
          email: emailController.text, password: passwordController.text);
    } catch (error) {
      setState(() {
        print(error);
        errorMessage = error.toString();
      });
    }
  }
}

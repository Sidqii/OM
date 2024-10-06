import 'package:flutter/material.dart';
import 'package:pusdatin/widgets/custom_scaffold.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: const Text('Sign up'),
    );
  }
}

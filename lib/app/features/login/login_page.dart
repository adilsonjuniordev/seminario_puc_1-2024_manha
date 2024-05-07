import 'package:flutter/material.dart';
import 'package:puc_minas/app/core/constants/app_assets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            Image.asset(AppAssets.logo),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Insira seu CPF',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Insira sua senha',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

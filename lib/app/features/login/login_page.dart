import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:puc_minas/app/core/constants/app_assets.dart';
import 'package:puc_minas/app/core/constants/app_routes.dart';
import 'package:puc_minas/app/features/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final cpfEC = TextEditingController();
  final passwordEC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(AppAssets.logo),
                TextFormField(
                  validator: Validatorless.multiple([
                    Validatorless.cpf('O CPF é inválido'),
                    Validatorless.required('O campo é obrigatório'),
                  ]),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                  controller: cpfEC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Insira seu CPF',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordEC,
                  validator: Validatorless.multiple([Validatorless.required('O campo é obrigatório'), Validatorless.min(6, 'Mínimo 6 caracteres')]),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Insira sua senha',
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    bool valid = formKey.currentState?.validate() ?? false;

                    if (valid) {
                      LoginControler.login(cpf: '', password: '');
                      Navigator.of(context).pushNamed(AppRoutes.home);
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('ACESSAR'),
                      SizedBox(width: 10),
                      Icon(Icons.login),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

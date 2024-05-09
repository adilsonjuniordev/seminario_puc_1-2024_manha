import 'dart:developer';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:puc_minas/app/core/models/product_model.dart';
import 'package:validatorless/validatorless.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final sizeEC = TextEditingController();
  final colorEC = TextEditingController();
  final descriptionEC = TextEditingController();
  final priceEC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Produto'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: Validatorless.required(
                    'Campo obrigatório',
                  ),
                  controller: descriptionEC,
                  decoration: const InputDecoration(hintText: 'Descrição do produto'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CentavosInputFormatter(moeda: true),
                  ],
                  validator: Validatorless.multiple([
                    Validatorless.required('Campo obrigatório'),
                  ]),
                  controller: priceEC,
                  decoration: const InputDecoration(hintText: 'Preço'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: Validatorless.required(
                    'Campo obrigatório',
                  ),
                  controller: colorEC,
                  decoration: const InputDecoration(hintText: 'Cor'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: Validatorless.required(
                    'Campo obrigatório',
                  ),
                  controller: sizeEC,
                  decoration: const InputDecoration(
                    hintText: 'Tamanho',
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        Color color = switch (colorEC.text.toLowerCase()) {
                          'vermelho' => Colors.red,
                          'verde' => const Color.fromRGBO(76, 175, 80, 1),
                          'azul' => Colors.blue,
                          _ => Colors.black,
                        };

                        ProductModel product = ProductModel(
                          size: sizeEC.text,
                          price: priceEC.text,
                          color: color,
                          description: descriptionEC.text,
                        );

                        Navigator.of(context).pop(product);
                      }
                    },
                    child: const Text(
                      'CADASTRAR',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

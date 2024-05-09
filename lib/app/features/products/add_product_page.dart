import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextFormField(
              controller: descriptionEC,
              decoration: const InputDecoration(hintText: 'Descrição do produto'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: priceEC,
              decoration: const InputDecoration(hintText: 'Preço'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: colorEC,
              decoration: const InputDecoration(hintText: 'Cor'),
            ),
            const SizedBox(height: 10),
            TextFormField(
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
                onPressed: () {},
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
    );
  }
}

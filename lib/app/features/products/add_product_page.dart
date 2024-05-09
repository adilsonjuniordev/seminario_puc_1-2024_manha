import 'package:brasil_fields/brasil_fields.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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

  Color selectedColor = Colors.green;

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
                GestureDetector(
                  onTap: () async {
                    await showColorPickerDialog(
                      context,
                      selectedColor,
                      actionButtons: const ColorPickerActionButtons(
                        closeButton: false,
                      ),
                      pickersEnabled: {
                        ColorPickerType.primary: true,
                        ColorPickerType.wheel: true,
                        ColorPickerType.accent: false,
                        ColorPickerType.custom: false,
                      },
                      pickerTypeLabels: {
                        ColorPickerType.primary: 'Cor primária',
                        ColorPickerType.wheel: 'Manual',
                      },
                      elevation: 2,
                      backgroundColor: Colors.white,
                      selectedColorIcon: Icons.check,
                      copyPasteBehavior: const ColorPickerCopyPasteBehavior(copyButton: true),
                      barrierColor: Colors.black.withOpacity(0.8),
                      borderColor: Colors.black12,
                      wheelHasBorder: true,
                      wheelSquareBorderRadius: 0,
                      title: const Text('Selecionar Cor'),
                      hasBorder: false,
                      borderRadius: 50,
                    ).then((color) => selectedColor = color);
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Selecionar cor:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: selectedColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ],
                    ),
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

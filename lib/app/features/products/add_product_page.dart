import 'dart:developer';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:puc_minas/app/core/models/product_model.dart';
import 'package:validatorless/validatorless.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final colorEC = TextEditingController();
  final descriptionEC = TextEditingController();
  final priceEC = TextEditingController();

  Color selectedColor = Colors.green;

  String size = 'Médio';

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
                const SizedBox(height: 20),
                CustomRadioButton(
                  buttonLables: const [
                    'Pequeno',
                    'Médio',
                    'Grande',
                  ],
                  buttonValues: const [
                    'Pequeno',
                    'Médio',
                    'Grande',
                  ],
                  radioButtonValue: (str) {
                    size = str;
                  },
                  autoWidth: true,
                  unSelectedColor: Colors.white,
                  selectedColor: Colors.green,
                  shapeRadius: 10,
                  enableShape: true,
                  enableButtonWrap: true,
                  elevation: 5,
                  defaultSelected: size,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    await showColorPickerDialog(
                      context,
                      selectedColor,
                      actionButtons: const ColorPickerActionButtons(
                        closeButton: true,
                      ),
                      barrierDismissible: false,
                      barrierColor: Colors.black.withOpacity(0.7),
                      backgroundColor: Colors.white,
                      pickersEnabled: {
                        ColorPickerType.primary: true,
                        ColorPickerType.accent: false,
                        ColorPickerType.wheel: true,
                      },
                      pickerTypeLabels: {
                        ColorPickerType.primary: 'Cor primária',
                        ColorPickerType.wheel: 'Cromático',
                      },
                      elevation: 2,
                      title: const Text('Selecione a cor do produto'),
                      runSpacing: 15,
                      spacing: 15,
                    ).then((color) {
                      selectedColor = color;
                      setState(() {});
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Selecione a cor:'),
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
                        ProductModel product = ProductModel(
                          size: size,
                          price: priceEC.text,
                          color: selectedColor,
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
            ).animate().slideY(begin: 1, end: 0, duration: 300.ms),
          ),
        ),
      ),
    );
  }
}

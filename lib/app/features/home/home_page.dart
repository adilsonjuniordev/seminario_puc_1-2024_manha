import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:puc_minas/app/core/components/product_card.dart';
import 'package:puc_minas/app/core/constants/app_routes.dart';
import 'package:puc_minas/app/core/models/product_model.dart';
import 'package:puc_minas/app/features/home/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        actions: [
          IconButton(
            onPressed: () async {
              var loggedOut = await HomeController.logout();
              if (loggedOut) {
                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
              }
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var product = await Navigator.of(context).pushNamed(AppRoutes.add);

          if (product != null) {
            products.add(product as ProductModel);
            setState(() {});
          }
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            products.isEmpty
                ? const Center(child: Text('Nenhum produto'))
                : ListView.builder(
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductCard(product: products[index]),
                    ),
                    shrinkWrap: true,
                    itemCount: products.length,
                  ),
          ],
        ),
      ),
    );
  }
}

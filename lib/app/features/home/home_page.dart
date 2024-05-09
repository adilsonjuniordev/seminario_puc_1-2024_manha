import 'package:flutter/material.dart';
import 'package:puc_minas/app/core/constants/app_routes.dart';
import 'package:puc_minas/app/features/home/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.add);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Container(),
    );
  }
}

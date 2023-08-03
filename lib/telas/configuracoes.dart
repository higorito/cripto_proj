import 'package:flutter/material.dart';


class Configs extends StatelessWidget {
  const Configs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: const Center(
        child: Text(
          'Configurações',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
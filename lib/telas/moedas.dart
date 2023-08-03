import 'package:flutter/material.dart';


class Moedas extends StatelessWidget {
  const Moedas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moedas', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueGrey[700],
        centerTitle: true,
      ),
      body: const Text('Moedas corpo'),
    );
  }
}
import 'package:cripto_proj/telas/moedas.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Começo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
       // colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 107, 21, 255)),
        useMaterial3: true,
      ),
      home: Moedas(),
    );
  }
}
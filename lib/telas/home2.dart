import 'package:cripto_proj/telas/tab_page.dart';
import 'package:flutter/material.dart';

class Home2 extends StatelessWidget {
  const Home2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DefaultTabController(length: 3, child: TabPage()),
    );
  }
}
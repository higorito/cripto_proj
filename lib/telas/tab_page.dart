import 'package:cripto_proj/telas/home.dart';
import 'package:cripto_proj/telas/home2.dart';
import 'package:cripto_proj/telas/logar.dart';
import 'package:cripto_proj/telas/moedas.dart';
import 'package:flutter/material.dart';

class TabPage extends StatelessWidget {
  const TabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const TabBarView(
        children: [
          Home2(),
          Moedas(),
          Logar(),
        ],
      ),
      bottomNavigationBar: TabBar(
        tabs: const [
          Tab(
            icon: Icon(Icons.home),
            text: "Home",
          ),
          Tab(
            icon: Icon(Icons.monetization_on_outlined),
            text: "Moedas",
          ),
          Tab(
            icon: Icon(Icons.settings_rounded),
            text: "Configurações",
          ),
        ],
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.black38,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: const EdgeInsets.all(5.0),
        indicatorColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
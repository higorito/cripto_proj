import 'package:cripto_proj/telas/configuracoes.dart';
import 'package:cripto_proj/telas/home.dart';
import 'package:flutter/material.dart';


import '../telas/home_cripto.dart';
import '../telas/logar.dart';
import '../telas/moedas.dart';



class Rotas extends StatelessWidget {
  const Rotas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Começo',
      
      initialRoute: '/homeCripto',
   //nao to usando aqui
      routes: {
        '/logar': (context) => const Logar(),
        '/moedas': (context) => const Moedas(),
        '/home': (context) => const Home(),
        '/configs': (context) => const Configs(),
        '/homeCripto' : (context) => const HomeCripto(),
      },
    );
  }
}
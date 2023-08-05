import 'package:cripto_proj/repositorios/favoritas_repo.dart';
import 'package:cripto_proj/rotas/rotas.dart';
import 'package:cripto_proj/rotas/tela_main_rota.dart';
import 'package:cripto_proj/telas/home_cripto.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => FavoritasRepo()),
    ], child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TelaMainRota(),)   //lembrar de envolver o widget na material(documentacao do provider nao fala isso)
    ),
    
  );
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Começo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//        // colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 107, 21, 255)),
//         useMaterial3: true,
//       ),
//       home: TelaMainRota(),  //nao to passando a rota aqui pq vou mudara a logica de navegacao
//     );
//   }
// }
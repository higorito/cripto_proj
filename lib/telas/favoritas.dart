import 'package:cripto_proj/_core/cores.dart';
import 'package:cripto_proj/componentes/card_moeda.dart';
import 'package:cripto_proj/repositorios/favoritas_repo.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Favoritas extends StatefulWidget {
  const Favoritas({super.key});

  @override
  State<Favoritas> createState() => _FavoritasState();
}

class _FavoritasState extends State<Favoritas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.fundo,
      appBar: AppBar(
        title: const Text('Favoritas', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),),
        centerTitle: true,
        elevation: 5,
        backgroundColor: Cores.appBarBackAzul,
      ),
      body: Container(
        color: Cores.fundo,
        padding: const EdgeInsets.all(12),
        child: Consumer<FavoritasRepo>(builder: (context, favoritasRepoLate, child){
          return favoritasRepoLate.moedasFavoritas.isEmpty ? const ListTile(
            leading: Icon(Icons.star, color: Colors.grey,),
            title: Text('Nenhuma moeda favorita', style: TextStyle(color: Colors.grey),),
          )
          :
          ListView.builder(
            itemCount: favoritasRepoLate.moedasFavoritas.length,
            itemBuilder: (_,index ){
              return MoedaCard(moeda: favoritasRepoLate.moedasFavoritas[index],);
            }
            );
        },)
      ),
    );
  }
}
import 'dart:collection';

import 'package:cripto_proj/adapters/moeda_model_hive.dart';
import 'package:cripto_proj/modelos/moeda_model.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

//depois tem q chamar na raiz do app
class FavoritasRepo extends ChangeNotifier {   //ChangeNotifier notifica o flluter pra redesenhar
  
  List<MoedaModel> _moedasFavoritas = []; //lista de moedas favoritas

  late LazyBox box; //lazybox pq nao vai abrir o box agora, so quando for usar
  FavoritasRepo() {  //construtor
    _iniciarRepo();
  }

  _iniciarRepo() async {
    await _iniciarHive();
    await _carregarFavoritas();
  }

  _iniciarHive() async {
    Hive.registerAdapter(MoedaModelHiveAdapter()); //registrando o adapter
    box = await Hive.openLazyBox<MoedaModel>('favoritasBox'); //abre o box do tipo moeda model
  }

  _carregarFavoritas() {
    box.keys.forEach((moeda) async {  //pra cada moeda no box, legal que marca o forEach como async 
      MoedaModel mo = await box.get(moeda);
      _moedasFavoritas.add(mo);
      notifyListeners(); //notifica o flutter pra redesenhar
    });
  }
  

  UnmodifiableListView<MoedaModel> get moedasFavoritas => UnmodifiableListView(_moedasFavoritas); 

  salvarTudo(List<MoedaModel> moedas){
    moedas.forEach((moeda) { 
      if(! _moedasFavoritas.any((atual) => atual.sigla == moeda.sigla)){ //estamos salvando objetos, entao nao da pra usar o contains, terao os mesmos dados, entao temos que usar o any e comparar valores unicos de cada objeto
        _moedasFavoritas.add(moeda);
        box.put(moeda.sigla, moeda); //salva no box
      }
      });
      notifyListeners();
  }

  remover(MoedaModel moeda){
    _moedasFavoritas.remove(moeda);
    box.delete(moeda.sigla);
    notifyListeners();
  }

}
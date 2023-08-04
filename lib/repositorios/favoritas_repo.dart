import 'dart:collection';

import 'package:cripto_proj/modelos/moeda_model.dart';
import 'package:flutter/material.dart';

//depois tem q chamar na raiz do app
class FavoritasRepo extends ChangeNotifier {   //ChangeNotifier notifica o flluter pra redesenhar
  
  List<MoedaModel> _moedasFavoritas = []; //lista de moedas favoritas

  UnmodifiableListView<MoedaModel> get moedasFavoritas => UnmodifiableListView(_moedasFavoritas); 

  salvarTudo(List<MoedaModel> moedas){
    moedas.forEach((moeda) { 
      if (! _moedasFavoritas.contains(moeda) ) {
        _moedasFavoritas.add(moeda);
      }
      });
      notifyListeners();
  }

  remover(MoedaModel moeda){
    _moedasFavoritas.remove(moeda);
    notifyListeners();
  }

}
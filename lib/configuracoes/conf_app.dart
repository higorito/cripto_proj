import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hive/hive.dart';

class ConfApp extends ChangeNotifier {   //pq vai criar um provider
    //late SharedPreferences _prefs;
    late Box box;  //formato do hive
    Map<String, String> localizacao = {
      'local': 'pt_BR',
      'tipoMoeda': 'BRL',
    };
  
    ConfApp() {
      _carregarConfigs();
    }

    _carregarConfigs() async {
      await _carregarPrefs();
      await _carregarLocalizacao();
    }

    Future<void> _carregarPrefs() async {
      //_prefs = await SharedPreferences.getInstance();
      box = await Hive.openBox('confAppBox'); //abre o box
    }

    _carregarLocalizacao() {
      final local = box.get('local') ?? 'pt_BR';
      final tpMoeda = box.get('tipoMoeda') ?? 'BRL';

      localizacao = {
        'local': local,
        'tipoMoeda': tpMoeda,
      };
    }
   

   setLocalizacao(String local, String tpMoeda) async {
     await box.put('local', local);
     await box.put('tipoMoeda', tpMoeda);
     _carregarLocalizacao();
     notifyListeners();
   }

}
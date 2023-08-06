import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfApp extends ChangeNotifier {   //pq vai criar um provider
    late SharedPreferences _prefs;
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
      _prefs = await SharedPreferences.getInstance();
    }

    _carregarLocalizacao() {
      final local = _prefs.getString('local') ?? 'pt_BR';
      final tpMoeda = _prefs.getString('tipoMoeda') ?? 'BRL';

      localizacao = {
        'local': local,
        'tipoMoeda': tpMoeda,
      };
    }
   

   setLocalizacao(String local, String tpMoeda) async {
     _prefs.setString('local', local);
     _prefs.setString('tipoMoeda', tpMoeda);
     _carregarLocalizacao();
     notifyListeners();
   }

}
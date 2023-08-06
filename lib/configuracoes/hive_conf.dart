import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveConf {
  
  static iniciar() async {
    Directory dir = await getApplicationDocumentsDirectory();  //pega o diretorio do app
    await Hive.initFlutter(dir.path);  //inicia o hive
  }
}
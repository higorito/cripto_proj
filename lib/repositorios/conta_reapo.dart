import 'package:cripto_proj/database/db_sql_auxiliador.dart';
import 'package:cripto_proj/modelos/selecao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';


class ContaRepositorio extends ChangeNotifier {  //para notificar 
  late Database db;
  List<Selecao> _carteira = [];
  double _saldo = 0.0;

  get saldo => _saldo;
  List<Selecao> get carteira => _carteira;

  ContaRepositorio() {
    _initDbRepositorio();
  }

  _initDbRepositorio() async {
    await _getSaldo();
  }

  _getSaldo() async {
    db = await DbSqlAuxiliador.instance.database;  //pega a instancia do banco de dados e dai pode mexer nele
    List conta = await db.query('conta');
    _saldo = conta[0]['saldo'];
    notifyListeners();
  }

  setSaldo(double valor)async{
    db = await DbSqlAuxiliador.instance.database;  //mesma coisa
    await db.update('conta', {'saldo': valor});
    _saldo = valor;
    notifyListeners();  //notifica os listeners
  }

}
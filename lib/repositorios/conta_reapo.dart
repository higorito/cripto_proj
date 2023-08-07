import 'package:cripto_proj/database/db_sql_auxiliador.dart';
import 'package:cripto_proj/modelos/historico_model.dart';
import 'package:cripto_proj/modelos/moeda_model.dart';
import 'package:cripto_proj/modelos/selecao.dart';
import 'package:cripto_proj/repositorios/moeda_repositorio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';


class ContaRepositorio extends ChangeNotifier {  //para notificar 
  late Database db;
  List<Selecao> _carteira = [];
  List<HistoricoModel> _historico = [];
  double _saldo = 0.0;

  get saldo => _saldo;
  List<Selecao> get carteira => _carteira;
  List<HistoricoModel> get historico => _historico;

  ContaRepositorio() {
    _initDbRepositorio();
    _getCarteira();
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

  comprar(MoedaModel moeda, double valor)async {
    db = await DbSqlAuxiliador.instance.database; 
    await db.transaction((txn) async{
      //se comprado so soma
      final posMoeda = await txn.query('carteira', where: 'sigla = ?', whereArgs: [moeda.sigla],
      );
      
      if (posMoeda.isEmpty) {
        await txn.insert('carteira', {
          'sigla': moeda.sigla,
          'nome': moeda.nome,
          'quantidade': (valor/moeda.cotacao).toString() //valor em reais dividido pela cotacao e transformado em string por causa da precisao do double
        });
      } else{
        final posAtual = double.parse(posMoeda[0]['quantidade'].toString());
        await txn.update('carteira', {
          'quantidade': (posAtual + (valor/moeda.cotacao)).toString()
  
        }, where: 'sigla = ?', whereArgs: [moeda.sigla]
        );
      }

     //colocando no historico
     await txn.insert('transacaoHist', {
       'data_operacao': DateTime.now().millisecondsSinceEpoch,
       'sigla': moeda.sigla,
       'tipo_operacao': 'compra',
       'quantidade': (valor/moeda.cotacao).toString(),
       'valor': moeda.cotacao.toString(),
      
     });

      //atualizando o saldo
      await txn.update('conta', {
        'saldo': _saldo - valor
      });

      //atualizando o repositorio
      await _initDbRepositorio();
      notifyListeners();


    }
    );
  }

  _getCarteira() async{
    _carteira = [];
    List listaPos = await db.query('carteira'); 
    
    listaPos.forEach((pos) {
      MoedaModel moeda = MoedaRepositorio.tabelaMoedas.firstWhere((mo) => mo.sigla == pos['sigla']);  //recuperando a moeda, fiz uma logica parecida em favoritas 
      _carteira.add(Selecao(moeda: moeda, quantidade: double.parse(pos['quantidade'].toString()))); //adicionando a carteira
    });

    notifyListeners();
  }

}
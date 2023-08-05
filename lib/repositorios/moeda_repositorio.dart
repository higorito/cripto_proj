//aq é utilizad para fazer a comunicação entre a view e o json

import 'package:cripto_proj/modelos/moeda_model.dart';

class MoedaRepositorio {  //depois colocar via API
  static List<MoedaModel> tabelaMoedas = [
    MoedaModel(icone: 'assets/icons/bitcoinCol.png', nome: 'Bitcoin', sigla: 'BTC', cotacao: 29281.10),
    MoedaModel(icone: 'assets/icons/ethereumCol.png', nome: 'Ethereum', sigla: 'ETH', cotacao: 1844.60),
    MoedaModel(icone: 'assets/icons/xrpnameCol.png', nome: 'XRP', sigla: 'XRP', cotacao: 0.6740),
    MoedaModel(icone: 'assets/icons/cardano.png', nome: 'Cardano', sigla: 'ADA', cotacao: 0.2952),
    MoedaModel(icone: 'assets/icons/dogecoin.png', nome: 'Dogecoin', sigla: 'DOGE', cotacao: 0.0743),
    MoedaModel(icone: 'assets/icons/tether.png', nome: 'Tether', sigla: 'USDT', cotacao: 0.9993),
    MoedaModel(icone: 'assets/icons/bnb.png', nome: 'Binance Coin', sigla: 'BNB', cotacao: 241.00),
    MoedaModel(icone: 'assets/icons/solana.png', nome: 'Solana', sigla: 'SOL', cotacao: 22.986),
    
  ];

}
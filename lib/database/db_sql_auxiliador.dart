import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; //importa o join

class DbSqlAuxiliador {   //legal ser no formato singleton para uma instancia 

    DbSqlAuxiliador._privateConstructor(); //construtor privado

    static final DbSqlAuxiliador instance = DbSqlAuxiliador._privateConstructor(); //instancia privada 

    static Database? _database ; //variavel que vai receber o banco de dados sqlite
    
    get database async { //metodo que vai retornar o banco de dados
      if (_database != null) return _database; //se o banco de dados ja foi criado, retorna ele
      
      return await _initDatabase(); //se nao, cria o banco de dados
    }


    _initDatabase() async{
      return await openDatabase(
        join(await getDatabasesPath(), 'cripto.db'),
        version: 1,

        onCreate: _onCreate, //metodo que vai criar as tabelas
      );
    }

    _onCreate(db, versao) async{
      await db.execute(_carteira);
      await db.execute(_conta);
      await db.execute(_transacaoHist);

      await db.insert('conta', {'saldo': 0.0});

    }

    String get _carteira => '''
      CREATE TABLE carteira (
        sigla TEXT PRIMARY KEY,
        nome TEXT,
        quantidade TEXT
      );
    '''; 
    
    String get _conta => '''
      CREATE TABLE conta (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        saldo REAL
      );
    ''';

    String get _transacaoHist => '''
      CREATE TABLE transacaoHist(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        data_operacao INT,
        sigla TEXT,
        tipo_operacao TEXT,
        quantidade REAL,
        valor REAL

      );
    ''';  //talvez seja necessario chava estrangeira para a tabela conta e/ou carteira
}
    
    
import 'package:cripto_proj/componentes/app_bar_custom.dart';
import 'package:cripto_proj/modelos/moeda_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../repositorios/moeda_repositorio.dart';

class HomeCripto extends StatefulWidget {
  const HomeCripto({super.key});

  @override
  State<HomeCripto> createState() => _HomeCriptoState();  //cria o estado da tela
}

class _HomeCriptoState extends State<HomeCripto> {

  List<MoedaModel> selecionadas = [];

    appBarCustomizadaEscopoL(){
    if(selecionadas.isEmpty){
      return AppBar(
      title: Text("Criptomoedas", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
      centerTitle: true,
      backgroundColor: Colors.blueGrey,
      shape: const RoundedRectangleBorder( //borda do appbar
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(32),),),
      );
    }else{
      return AppBar(
      title: Text("(${selecionadas.length}) selecionadas"),
      centerTitle: true,
      backgroundColor: Colors.blueGrey,
      shape: const RoundedRectangleBorder( //borda do appbar
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(32),),),
      
      leading: IconButton(
        icon: const Icon(Icons.close), 
        onPressed: (){
          setState(() {
            selecionadas.clear();
          });
        },),
      );
    }

    }

  @override
  Widget build(BuildContext context) {
    final tabela = MoedaRepositorio.tabelaMoedas; 
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
    NumberFormat dolar = NumberFormat.currency(locale: 'en_US', name: 'US\$');

    
    return Scaffold(
      appBar: appBarCustomizadaEscopoL(),

      backgroundColor: Colors.grey[300],
      body: ListView.separated(
        
        itemBuilder: (BuildContext context, int moeda){
          return ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      
            leading: 
            (selecionadas.contains(tabela[moeda])) ? 
              const CircleAvatar(child: Icon(Icons.check, color: Colors.black,), backgroundColor: Colors.green,) :
              SizedBox(width: 50,child: Image.asset(tabela[moeda].icone),),
            
            
            title: Text(tabela[moeda].nome, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
            subtitle: Text(tabela[moeda].sigla),
            trailing: Text(dolar.format(tabela[moeda].cotacao), style: const TextStyle(fontSize: 16),),
      
            //selected: true,
            selected: selecionadas.contains(tabela[moeda]), //se contem na lista de selecionadas, fica selecionado
            selectedTileColor: Colors.blueGrey[200],
            selectedColor: const Color.fromARGB(255, 0, 156, 34),
            onLongPress: () {
              
              setState(() {  //poderia ser ternario tmb
                if(selecionadas.contains(tabela[moeda])){
                  selecionadas.remove(tabela[moeda]);
                }else{
                  selecionadas.add(tabela[moeda]);
                }
              });
            
            },
          );
      
        },
        separatorBuilder: (_, __) => const Divider(color: Colors.black), 
        padding: const EdgeInsets.all(12),
        itemCount: tabela.length
        ),
      
      
    );
  }
}
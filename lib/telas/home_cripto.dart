import 'package:cripto_proj/componentes/app_bar_custom.dart';
import 'package:cripto_proj/modelos/moeda_model.dart';
import 'package:cripto_proj/telas/detalhes_moedas.dart';
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
      title: const Text("Criptomoedas", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white),),
      centerTitle: true,
      backgroundColor: const Color(0xff3d0739),
      shape: const RoundedRectangleBorder( //borda do appbar
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(32),),),
      elevation: 8,
      );
    }else{
      return AppBar(
      title: Text("(${selecionadas.length}) selecionadas"),
      centerTitle: true,
      backgroundColor: const Color(0xFF771d76),
      shape: const RoundedRectangleBorder( //borda do appbar
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(48),),),
      
      elevation: 10,

      iconTheme: const IconThemeData(color: Colors.white), 

      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),

      leading: IconButton(padding: const EdgeInsets.only(left: 32),
        icon: const Icon(Icons.close), 
        onPressed: (){
          setState(() {
            selecionadas.clear();
          });
        },),
      );
    }

    }

  mostrarDetalhes(MoedaModel moeda){
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => DetalhesMoedas(moeda: moeda), 

      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabela = MoedaRepositorio.tabelaMoedas; 
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
    NumberFormat dolar = NumberFormat.currency(locale: 'en_US', name: 'US\$');

    
    return Scaffold(
      appBar: appBarCustomizadaEscopoL(),

      backgroundColor:  Color(0xFF42213f),
      //backgroundColor: Color(0xFFb58eb1),
      body: Container(
        margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
        decoration: const BoxDecoration(
          //color: Color(0xFF42213f),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
          
          ),
          
        child: ListView.separated(
          
          itemBuilder: (BuildContext context, int moeda){
            return ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        
              leading: 
              (selecionadas.contains(tabela[moeda])) ? 
                const CircleAvatar(child: Icon(Icons.check, color: Colors.black,), backgroundColor: Color(0xFF579e48),) :
                SizedBox(width: 50,child: Image.asset(tabela[moeda].icone),),
              
              
              title: Text(tabela[moeda].nome, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),),
              subtitle: Text(tabela[moeda].sigla, style: const TextStyle(fontSize: 14, color: Colors.white70),),
              trailing: Text(dolar.format(tabela[moeda].cotacao), style: const TextStyle(fontSize: 16, color: Colors.white),),
        
              //selected: true,
              selected: selecionadas.contains(tabela[moeda]), //se contem na lista de selecionadas, fica selecionado
              selectedTileColor: const Color(0xFF579e48),
              selectedColor: const Color(0xFF277e1c),
              onLongPress: () {
                
                setState(() {  //poderia ser ternario tmb
                  if(selecionadas.contains(tabela[moeda])){
                    selecionadas.remove(tabela[moeda]);
                  }else{
                    selecionadas.add(tabela[moeda]);
                    
                  }
                });

              },

              onTap: () { mostrarDetalhes(tabela[moeda]); },

            );
        
          },
          separatorBuilder: (_, __) => const Divider(color: Color(0xFF8e698b) , height: 1,), 
          padding: const EdgeInsets.all(12),
          itemCount: tabela.length
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: 
      (selecionadas.isNotEmpty) ?
        FloatingActionButton.extended(
          onPressed: (){}, label: const Text("Comprar"),
          icon: const Icon(Icons.monetization_on),
          backgroundColor: const Color(0xFF277e1c),)
        : null,

    );
  }
}

import 'package:cripto_proj/_core/cores.dart';
import 'package:cripto_proj/modelos/moeda_model.dart';
import 'package:cripto_proj/repositorios/favoritas_repo.dart';
import 'package:cripto_proj/telas/detalhes_moedas.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../configuracoes/conf_app.dart';
import '../repositorios/moeda_repositorio.dart';

import 'package:provider/provider.dart';

class HomeCripto extends StatefulWidget {
  const HomeCripto({super.key});

  @override
  State<HomeCripto> createState() => _HomeCriptoState();  //cria o estado da tela
}

class _HomeCriptoState extends State<HomeCripto> {

  final tabela = MoedaRepositorio.tabelaMoedas; 
  //NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  //NumberFormat dolar = NumberFormat.currency(locale: 'en_US', name: 'US\$');

  late NumberFormat formato;
  late Map<String,String> loca;

  List<MoedaModel> selecionadas = [];

  late FavoritasRepo favoritasRepoLate;

    lerFormatoNum() {
      //loca = Provider.of<ConfApp>(context).localizacao; //pode ser assim ou: loca = context.watch<ConfApp>().localizacao;
      loca = context.watch<ConfApp>().localizacao;
      formato = NumberFormat.currency(locale: loca['local'], name: loca['tipoMoeda']);
    }

    mudarLinguagem(){
      final localizacao = loca['local'] == 'pt_BR' ? 'en_US' : 'pt_BR';
      final tipoMoeda = loca['tipoMoeda'] == 'BRL' ? 'USD' : 'BRL';

      return PopupMenuButton(
        icon: const Icon(Icons.language),
        itemBuilder: (context) => [
          PopupMenuItem(child: ListTile(
            leading: const Icon(Icons.swap_vert_circle),
            title: Text("Mudar para $localizacao"),
            onTap: (){
              context.read<ConfApp>().setLocalizacao(localizacao, tipoMoeda);
              Navigator.pop(context);
            },
            
          ),
          ),
        
        ]
      );
    }
  

    appBarCustomizadaEscopoL(){
    if(selecionadas.isEmpty){
      return AppBar(
      title: const Text("Criptomoedas", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white),),
      centerTitle: true,
      backgroundColor: Cores.roxoEscuro,
      shape: const RoundedRectangleBorder( //borda do appbar
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(32),),),
      elevation: 8,
      actions: [
        mudarLinguagem(),
      ],
      );
    }else{
      return AppBar(
      title: Text("(${selecionadas.length}) selecionadas"),
      centerTitle: true,
      backgroundColor: Cores.roxoAzulado,
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
      
      actions: [
        IconButton(
          padding: const EdgeInsets.only(right: 32),
          icon: const Icon(Icons.star, color: Colors.amber, ),
          onPressed: (){
            favoritasRepoLate.salvarTudo(selecionadas);
            setState(() {
              selecionadas.clear();
            });
          },),],
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
    favoritasRepoLate = Provider.of<FavoritasRepo>(context);  //recuperando as favoritas
    //favoritasRepoLate =  context.watch<FavoritasRepo>();  //esperar por mudanças ou read 

    lerFormatoNum();

    return Scaffold(
      appBar: appBarCustomizadaEscopoL(),

      backgroundColor:  Cores.fundo,
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
                const CircleAvatar(backgroundColor: Color(0xFF579e48),child: Icon(Icons.check, color: Colors.black,),) :
                SizedBox(width: 50,child: Image.asset(tabela[moeda].icone),),
              

              title: (favoritasRepoLate.moedasFavoritas.any((favorito) => favorito.sigla == tabela[moeda].sigla))?
                Row(
                  children: [
                    Text(tabela[moeda].nome, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.amber),),
                    const SizedBox(width: 4,),
                    const Icon(Icons.star, color: Colors.amber, size: 14,)
                  ],
                ) :
                Text(tabela[moeda].nome, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),),
              
              subtitle: Text(tabela[moeda].sigla, style: const TextStyle(fontSize: 14, color: Colors.white70),),
              trailing: Text(formato.format(tabela[moeda].cotacao), style: const TextStyle(fontSize: 16, color: Colors.white),),
        
              //selected: true,
              selected: selecionadas.contains(tabela[moeda]), //se contem na lista de selecionadas, fica selecionado
              selectedTileColor: Cores.verdeEscuro,
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
        Padding(
          padding: const EdgeInsets.only(left: 40 ),
          child: Row(
            children: [
              FloatingActionButton.extended(
                onPressed: (){}, label: const Text("Comprar"),
                icon: const Icon(Icons.monetization_on),
                backgroundColor: const Color(0xFF277e1c),
                ),
              const SizedBox(width: 10,),
              FloatingActionButton.extended(
                onPressed: (){}, label: const Text("Vender"),
                icon: const Icon(Icons.money_off),
                backgroundColor: const Color(0xFFFA4430),),
            ],
          ),
        )
        : null,

    );
  }
}
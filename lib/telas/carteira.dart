import 'package:cripto_proj/configuracoes/conf_app.dart';
import 'package:cripto_proj/modelos/selecao.dart';
import 'package:cripto_proj/repositorios/conta_reapo.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Carteira extends StatefulWidget {
  const Carteira({super.key});

  @override
  State<Carteira> createState() => _CarteiraState();
}

class _CarteiraState extends State<Carteira> {
  int index = 0; //para saber qual moeda ta selecionada no grafico
  double totCarteira = 0; 
  double saldo = 0; 

  late NumberFormat formatador; 
  late ContaRepositorio contaRepo;

   String graficoTxt = '';
    double graficoValor = 0.0;
    List<Selecao> carteira = [];

  @override
  Widget build(BuildContext context) {
    //inicializações que precisam ser feitas aqui, vieram do provider
    contaRepo = context.watch<ContaRepositorio>();
    final loca = context.read<ConfApp>().localizacao;
    formatador = NumberFormat.currency(locale: loca["local"], name: loca["tipoMoeda"]);
    
    saldo = contaRepo.saldo;
 //-----------------
   

    setTotCarteira();

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 28, left: 20, right: 20,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(top: 28,bottom: 12),
             child: Text("Valor da Carteira", style: TextStyle(fontSize: 18),
             ),
             ),
             Text(formatador.format(totCarteira), style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: -1.5),),

             carregamentoGrafico(),
          ],
        ),
      ),
    );
  }

  carregamentoGrafico(){
    
    return (contaRepo.saldo <=0) 
    ?Container(
      margin: EdgeInsets.only(top: 32),
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: Center(
        child: CircularProgressIndicator(color: Colors.red,),
      ),
    )
    :  Stack( //stack pq no meio tera algo
        alignment: Alignment.center,
        children: [
          AspectRatio(aspectRatio: 1,
            child: PieChart( //da biblioteca do grafico
              PieChartData(sectionsSpace: 3,
                centerSpaceRadius: 115,  //para deixar um circulo no meio
                pieTouchData: PieTouchData(
                                touchCallback: (touch) =>setState(() {
                                  index = touch.touchedSection!.touchedSectionIndex; 
                                  setGraficoDados(index); //para mudar o grafico quando tocar em uma moeda 
                                                                  }),
                ),
                sections: pegarDadosCarteira(),
              ),
            ),
          ),
          Column(
            children: [
              Text(graficoTxt, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.green),),
              Text(formatador.format(graficoValor), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
            ],
          ),
        ],
    );

  }

  setTotCarteira(){
    final listaCarteira = contaRepo.carteira;
    setState(() {
      totCarteira = contaRepo.saldo;
      
      for (var pos in listaCarteira){
        totCarteira += pos.moeda.cotacao * pos.quantidade;
      }

    });
  }

  setGraficoDados(int index){
    if (index <0) {
      return;
    }
    if (index == contaRepo.carteira.length){
      graficoTxt = 'Saldo';
      graficoValor = contaRepo.saldo;
    }else{
      graficoTxt = contaRepo.carteira[index].moeda.sigla;
      graficoValor = contaRepo.carteira[index].moeda.cotacao * contaRepo.carteira[index].quantidade;
    }
  }

  pegarDadosCarteira(){
    setGraficoDados(index);
    carteira = contaRepo.carteira;
    final tamLista = carteira.length + 1; //+1 para o saldo

    return List.generate(tamLista, (i)  {
      //declarar algumas variaveis para configurar o grafico
      final isTouched = i == index;
      final double fontSize = isTouched ? 18 : 15;
      final double radius = isTouched ? 70 : 55;
      final isSaldo = i == tamLista -1; //para saber se é o saldo
      final cor = isSaldo ? Colors.greenAccent : Colors.amber;

      double porc = 0.0;

      if (isSaldo){
        porc = (contaRepo.saldo > 0 )? saldo / totCarteira : 0;     
        }else{
          porc = carteira[i].moeda.cotacao * carteira[i].quantidade / totCarteira; //para saber a porcentagem de cada moeda
        }
        porc *=100;

      return PieChartSectionData(
        color: cor,
        value: porc,
        title: '${porc.toStringAsFixed(2)}%',
        radius: radius,
        titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 37, 37, 37)),
      );

      
    });
  }

}
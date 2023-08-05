import 'package:cripto_proj/_core/cores.dart';
import 'package:cripto_proj/componentes/input_custom.dart';
import 'package:cripto_proj/modelos/moeda_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DetalhesMoedas extends StatefulWidget {
  MoedaModel moeda;
  
  DetalhesMoedas({super.key, required this.moeda});
  
  @override
  State<DetalhesMoedas> createState() => _DetalhesMoedasState();
}

class _DetalhesMoedasState extends State<DetalhesMoedas> {

      //nao faco ideia do pq eu tinha colocado ele dentro do build
    NumberFormat dolar = NumberFormat.currency(locale: 'en_US', name: 'US\$');
    final _formKey = GlobalKey<FormState>();
    final _valor = TextEditingController(); 

    double qtd = 0;


  @override
  Widget build(BuildContext context) {

    comprarCripto(){
      if(_formKey.currentState!.validate()){
        //salvar a compra
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Comprado com Sucesso!!"), backgroundColor: Colors.green,),
        );
      }
    }
    
    return Scaffold(
      
      //aaa tmb n  resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.moeda.nome),
        centerTitle: true,
        backgroundColor: Cores.appBarBackAzul,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(22),),
        ),
        elevation: 12,
        iconTheme: const IconThemeData(color: Colors.white), 
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        
      ),
      body: Container(
        height: 450,
        margin: const EdgeInsets.fromLTRB(8, 22, 8, 22),
        
        decoration: const BoxDecoration(
          
          borderRadius: BorderRadius.vertical(top: Radius.circular(22), bottom: Radius.circular(22),),
          gradient: LinearGradient(
            colors: [
              Cores.roxoFundoGrad,
              Cores.roxoTopoGrad,
              
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
          
              child: Row( mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(widget.moeda.icone, width: 64, height: 64,),
                  const SizedBox(width: 8,),
                  Text(dolar.format(widget.moeda.cotacao), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),),
                ],
              ),
            ),
            (qtd>0)?
            SizedBox(
              width: MediaQuery.of(context).size.width*0.8,
              child: Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(64),
                ),
                child: Center(
                  child: Text(
                    "$qtd ${widget.moeda.sigla} = ${dolar.format(qtd * widget.moeda.cotacao)}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
            )
            :
            const SizedBox(height: 15,),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 22),
              child: Form(key: _formKey, 
              
                child: TextFormField(
                  
                  controller: _valor,
                  style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),

                  decoration: inputDecor("Valor em Dolar", Icons.monetization_on),
                  keyboardType: TextInputType.number,

                  inputFormatters: [FilteringTextInputFormatter.digitsOnly ],  //permite customizar o filtering... ate colocar expressao regular

                  
                  validator: (value){
                    if(value!.isEmpty){
                      return "Informe um valor";
                    }else if(double.parse(value) < 20){
                      return "Informe um valor maior que 20USD";
                    }
                    return null;
                  },
                  
                  onChanged: (value){
                    setState(() {
                      qtd = (value.isEmpty)? 0 : double.parse(value)/ widget.moeda.cotacao;  //se o valor for vazio, qtd = 0, senao, qtd = valor/cotacao
                    });
                  },
              ),
              ),
            ),

            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.fromLTRB(64, 12, 64, 32),
              child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Cores.roxoEscuro,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22),),
              ),
                onPressed: () {
                comprarCripto();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.price_check_outlined, size: 38,),
                  SizedBox(width: 10,),
                  Text("Comprar", style: TextStyle(fontSize: 20),),
                ],
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
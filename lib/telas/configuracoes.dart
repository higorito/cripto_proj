import 'package:cripto_proj/_core/cores.dart';
import 'package:cripto_proj/configuracoes/conf_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../repositorios/conta_reapo.dart';

class Configs extends StatefulWidget {
  const Configs({super.key});

  @override
  State<Configs> createState() => _ConfigsState();
}

class _ConfigsState extends State<Configs> {
  
  attSaldo() async{  //fazer um alert ai tera q pegar algumas variaveis 
    final form = GlobalKey<FormState>();
    final valor = TextEditingController();
    final conta = context.read<ContaRepositorio>();

    valor.text = conta.saldo.toString();

    AlertDialog telinha = AlertDialog(
                              title: const Text('Atualizar Saldo'),
                              content: Form(key: form,
                               child: TextFormField(
                                 controller: valor,
                                 keyboardType: TextInputType.number,
                                 inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')), ],
                                 validator: (value) {
                                   if(value == null || value.isEmpty) {
                                     return 'Campo obrigatório';
                                   }
                                   return null;
                                 },
                                 decoration: const InputDecoration(
                                   labelText: 'Saldo',
                                   border: OutlineInputBorder(),
                                 ),
                               ),
                                
                              ),
                              actions: [
                                TextButton.icon(onPressed: ()=> Navigator.pop(context), icon: const Icon(Icons.cancel), label: const Text('Cancelar')),
                                TextButton.icon(onPressed: (){
                                  if(form.currentState!.validate()){
                                    conta.setSaldo(double.parse(valor.text)); 
                                    Navigator.pop(context);
                                  }
                                }, icon: const Icon(Icons.save), label: const Text('Salvar')),
                              ],
    );    
    showDialog(context: context, builder: (context) => telinha, barrierDismissible: false,) ; //barrierDismissible: false, impede de fechar o alert clicando fora dele
  }


  @override
  Widget build(BuildContext context) {
    //final conta = Provider.of<ContaRepositorio>(context); deu ruim
    final conta = context.watch<ContaRepositorio>();
    final loca = context.read<ConfApp>().localizacao; 
    NumberFormat formatador = NumberFormat.currency(locale: loca['local'] , name: loca['tipoMoeda']);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),),
        centerTitle: true,
        elevation: 5,
        backgroundColor: Cores.appBarBackAzul,
      ),

      body: Padding(padding: const EdgeInsets.all(12),
        child: Column(children: [
          ListTile(
            
            title: const Text('Saldo da Conta:', style: TextStyle(fontSize: 22, ),),
            subtitle: Text(formatador.format(conta.saldo), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed:  attSaldo //função que atualiza o saldo
              
            ),
          ),
          const Divider(color: Cores.cinzaEscuro, height: 30, indent: 10, endIndent: 10, thickness: 1,),
        ]),
       ),
    );
    
  }
   
  
}
import 'package:flutter/material.dart';

AppBar appBarCustomizada(String titulo, int? tamSelecionadas){
  if(tamSelecionadas == 0){
    return AppBar(
    title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
    centerTitle: true,
    backgroundColor: Colors.blueGrey,
    shape: const RoundedRectangleBorder( //borda do appbar
    borderRadius: BorderRadius.vertical(bottom: Radius.circular(32),),),
    );
  }else{
    return AppBar(
    title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
    centerTitle: true,
    backgroundColor: Colors.blueGrey,
    shape: const RoundedRectangleBorder( //borda do appbar
    borderRadius: BorderRadius.vertical(bottom: Radius.circular(32),),),

    leading: IconButton(
      icon: Icon(Icons.close), 
      onPressed: (){
        
      },),
    );
  }

}
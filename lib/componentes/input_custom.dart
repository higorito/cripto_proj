import 'package:flutter/material.dart';


InputDecoration inputDecor(String label, IconData icones){

  return InputDecoration(
      //label: Text(label, style: const TextStyle(color: Colors.grey),),
      //hintText: Text(label, style: const TextStyle(color: Colors.red),).data.toString(),
      
      hintText: label,
      fillColor: const Color(0xFF8e698b),
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      prefixIcon: Icon(icones, color: const Color(0xFF579e48),),
      suffix: const Text("USD", style: TextStyle(fontSize: 16,color: Color.fromARGB(255, 5, 5, 5)),),
      

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: Color(0xFF579e48), width: 2)
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: Color(0xFF277e1c), width: 3.5)
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: Colors.red, width: 2)
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: Colors.red, width: 3.5)
      ),
  );
}
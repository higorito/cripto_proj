import 'package:flutter/material.dart';

class Logar extends StatelessWidget {
  const Logar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueGrey[700],
        centerTitle: true,
      ),
      body: Center(
        child:Column(children: [
          const Text('Logar corpo'),
          ElevatedButton(
            onPressed: () {
             //Navigator.push(context, MaterialPageRoute(builder: (context) => const Moedas() ),   );
              Navigator.pushNamed(context, '/home');
            },
            child: const Text('Ir para moedas'),
          ),
        ],
        ),
      ),
    );
  }
}
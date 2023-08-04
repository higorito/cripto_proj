import 'package:cripto_proj/telas/favoritas.dart';
import 'package:cripto_proj/telas/home_cripto.dart';
import 'package:flutter/material.dart';

class TelaMainRota extends StatefulWidget {
  const TelaMainRota({super.key});

  @override
  State<TelaMainRota> createState() => _TelaMainRotaState();
}

class _TelaMainRotaState extends State<TelaMainRota> {
  int pgAtual = 0;
  late PageController pController;

  @override
  void initState() {    //ciclo de vida do widget (revisar se necessário)
    // TODO: implement initState
    super.initState();
    pController = PageController(initialPage: pgAtual);
  }

  setPgAtual(int pagina){  //facil para mudar a cor da pagina atual no botttom navigation bar
    setState(() {
      pgAtual = pagina; 
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pController,
        children: [
            HomeCripto(),
            Favoritas(),
        ],
        onPageChanged: setPgAtual,
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pgAtual,
        items: const [BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
         BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritas') ],
        
        selectedIconTheme: IconThemeData(color: Colors.purple[800]),
        unselectedIconTheme: IconThemeData(color: Colors.grey[600]),
  

        onTap: (pagina){
          pController.animateToPage(pagina, duration: const Duration(milliseconds: 450), curve: Curves.easeInExpo);
        },
        backgroundColor: Colors.grey[300],
        ),
    );
  }
}
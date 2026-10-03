import 'package:flutter/material.dart';
//crie uma classe chamada App e faça com que ela herde de StatelessWidget
class App extends StatelessWidget {

// escreva um método chamado build cujo tipo de retorno é Widget. Ela deve receber um parâmetro chamado context do tipo BuildContext
  @override
  Widget build(BuildContext context) {
    //retorne um widget do tipo MaterialApp
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Minhas imagens')),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            print('Hello');
          },
        ), //AppBar
      ),
    );
  }
}
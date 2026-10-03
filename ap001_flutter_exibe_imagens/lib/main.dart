import 'package:flutter/material.dart';
import 'src/app.dart';

void main() {
  var app = MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Minhas imagens')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          print('Estou no arquivo app.dart');
        },
      ), //AppBar
    ),
  );
  runApp(app);
}

import 'package:ap003_dart_colecoes/ap003_dart_colecoes.dart'
    as ap003_dart_colecoes;

import 'dart:io';

void main() {
  final contatos = <String, int>{};
  var rodando = true;

  while (rodando) {
    print('\n1-Create 2-Read 3-Update 4-Delete 5-Sair');
    stdout.write('Escolha: ');
    final opcao = int.tryParse(stdin.readLineSync() ?? '');

    switch (opcao) {
      case 1:
        stdout.write('Nome: ');
        final nome = stdin.readLineSync() ?? '';
        stdout.write('Numero: ');
        final numero = int.tryParse(stdin.readLineSync() ?? '');
        if (numero == null) {
          print('Numero invalido.');
        } else {
          contatos[nome] = numero;
        }
      case 2:
        print(contatos.isEmpty ? 'Vazio.' : contatos);
      case 5:
        rodando = false;
      default:
        print('Opcao invalida.');
    }
  }
}

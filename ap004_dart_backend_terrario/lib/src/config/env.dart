import 'package:dotenv/dotenv.dart';

// private Env(){}
class Env {
  Env._();
  //require('dotenv').config()
  static final DotEnv _env = DotEnv(includePlatformEnvironment: true)..load();

  static String obrigatoria(String chave) {
    final valor = _env[chave];
    if (valor == null || valor.trim().isEmpty) {
      throw Exception(
        'Variavel de ambiente obrigatoria nao encontrada: $chave',
      );
    }
    return valor.trim();
  }

  static String opcional(String chave, String padrao) {
    final valor = _env[chave];
    return (valor == null || valor.trim().isEmpty) ? padrao : valor.trim();
  }

  static int inteiro(String chave, int padrao) {
    final bruto = _env[chave];
    if (bruto == null || bruto.trim().isEmpty) return padrao;
    final valor = int.tryParse(bruto.trim());
    if (valor == null) {
      throw StateError('A variável $chave deve ser um número inteiro: $bruto');
    } 
    return valor;
  }
}

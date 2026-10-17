// Importa o pacote dotenv, que lê o arquivo `.env` e expõe as variáveis.
import 'package:dotenv/dotenv.dart';

/// Ponto único de leitura de variáveis de ambiente.
///
/// A instância de [DotEnv] é criada uma única vez, de forma preguiçosa, na
/// primeira leitura. Quando o arquivo `.env` não existe — situação normal
/// dentro de um contêiner — o pacote simplesmente não carrega nada e as
/// variáveis reais do processo continuam disponíveis.
class Env {
  // Construtor privado (o `_` torna o membro privado à biblioteca):
  // impede que alguém faça `Env()`, já que a classe só tem membros estáticos.
  Env._();

  // Equivalente ao `require('dotenv').config()` do Node.
  // `includePlatformEnvironment: true` também considera as variáveis do SO.
  // `..load()` é o operador cascata: chama load() e devolve o próprio objeto.
  // Campos `static final` em Dart são inicializados só no primeiro acesso.
  static final DotEnv _env = DotEnv(includePlatformEnvironment: true)..load();

  /// Lê uma variável obrigatória. Lança [StateError] se ela estiver ausente
  /// ou vazia, interrompendo a inicialização em vez de deixar o servidor
  /// subir com configuração incompleta.
  static String obrigatoria(String chave) {
    final valor = _env[chave]; // Busca a variável; pode vir null.
    if (valor == null || valor.trim().isEmpty) {
      // Ausente ou só com espaços: falha logo no boot.
      throw StateError('Variável de ambiente obrigatória ausente: $chave');
    }
    return valor.trim(); // Devolve o valor sem espaços nas pontas.
  }

  /// Lê uma variável opcional, devolvendo [padrao] quando ela não existe.
  static String opcional(String chave, String padrao) {
    final valor = _env[chave]; // Busca a variável; pode vir null.
    // CORRIGIDO: antes devolvia `chave.trim()` (o NOME da variável) em vez do valor.
    return (valor == null || valor.trim().isEmpty) ? padrao : valor.trim();
  }

  /// Lê um inteiro, recusando valores que não sejam numéricos.
  static int inteiro(String chave, int padrao) {
    final bruto = _env[chave]; // Texto cru da variável.
    if (bruto == null || bruto.trim().isEmpty) return padrao; // Ausente: usa o padrão.
    final valor = int.tryParse(bruto.trim()); // tryParse devolve null se não for número.
    if (valor == null) {
      // Valor presente mas inválido (ex.: "abc"): melhor falhar do que ignorar.
      throw StateError('A variável $chave deve ser um número inteiro: $bruto');
    }
    return valor; // Número já convertido.
  }
}

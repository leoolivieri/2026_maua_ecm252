import 'dart:io'; // InternetAddress e stdout.

import 'package:ap004_dart_backend_terrario/src/config/app_config.dart'; // Configuração.
import 'package:shelf/shelf.dart'; // Request e Response.
import 'package:shelf/shelf_io.dart' as shelf_io; // Servidor HTTP do shelf.

// `Future<T>` é o equivalente em Dart à Promise do JavaScript: um valor que
// ainda não chegou. `async` marca a função que devolve um Future e `await`
// pausa a execução até ele completar, exatamente como no JavaScript
// (que também pode usar then/catch, como o Dart com .then/.catchError).

/// Ponto de entrada do servidor (`dart run bin/server.dart`).
Future<void> main(List<String> arguments) async {
  // Resolve e valida toda a configuração antes de abrir qualquer porta.
  final config = AppConfig.fromEnv();

  // Handler: função que recebe uma requisição e devolve uma resposta.
  // Por enquanto toda rota responde 200 com o mesmo texto.
  Response handler(Request request) {
    return Response.ok('API de Terrarios funcionando...');
  }

  // Equivalente ao `app.listen` do Express.
  // InternetAddress.anyIPv4 (0.0.0.0) é obrigatório dentro de contêineres:
  // ouvir apenas em localhost tornaria o servidor inacessível de fora dele.
  final servidor = await shelf_io.serve(
    handler,
    InternetAddress.anyIPv4,
    config.serverPort,
  );

  stdout.writeln('Servidor ouvindo em http://localhost:${servidor.port}');
  stdout.writeln(config); // Usa o toString() seguro (sem senha).
}

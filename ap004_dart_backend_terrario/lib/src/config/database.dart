// Driver MySQL: fornece MySQLConnectionPool, ResultSetRow etc.
import 'package:mysql_dart/mysql_client.dart';
import 'app_config.dart'; // Configuração com os dados de conexão.

/// Cria o pool de conexões com o MySQL a partir da configuração.
/// Um pool reaproveita conexões abertas em vez de abrir uma nova por consulta.
MySQLConnectionPool criarPool(AppConfig config) {
  return MySQLConnectionPool(
    host: config.dbHost, // Endereço do servidor.
    port: config.dbPort, // Porta.
    userName: config.dbUser, // Usuário.
    password: config.dbPassword, // Senha.
    databaseName: config.dbName, // Banco usado por padrão.
    maxConnections: config.dbPoolSize, // Limite de conexões simultâneas.
    secure: false, // Sem TLS (ok em desenvolvimento local).
    allowPublicKeyRetrieval: true, // Necessário p/ autenticação do MySQL 8 sem TLS.
  );
}

/// Espera o banco aceitar conexões, tentando `SELECT 1` várias vezes.
/// Útil porque o contêiner do MySQL demora alguns segundos para subir.
Future<void> aguardarBanco(
  MySQLConnectionPool pool, {
  int tentativas = 30, // CORRIGIDO: estava escrito `tentaivas`.
  Duration intervalo = const Duration(seconds: 2), // Pausa entre tentativas.
}) async {
  for (var tentativa = 1; tentativa <= tentativas; tentativa++) {
    try {
      await pool.execute('SELECT 1'); // Consulta mínima: só testa a conexão.
      return; // Funcionou: o banco está pronto.
    } catch (_) {
      // CORRIGIDO: `catch ( )` precisa de um nome; `_` = "não vou usar".
      if (tentativa == tentativas) rethrow; // Última tentativa: propaga o erro.
      // CORRIGIDO: era `await Future<void> Future.delayed(intervalo)` sem `;`.
      await Future<void>.delayed(intervalo); // Espera antes de tentar de novo.
    }
  }
}

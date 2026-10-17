// CORRIGIDO: removido `import 'dart:developer'`, que não era usado (gerava aviso).
import 'env.dart'; // Leitor de variáveis de ambiente.

/// Configuração da aplicação, resolvida uma única vez durante o boot.
class AppConfig {
  // Construtor `const` com parâmetros nomeados obrigatórios (`required`).
  // `this.campo` atribui o argumento direto ao campo de mesmo nome.
  const AppConfig({
    required this.appEnv,
    required this.serverPort,
    required this.logLevel,
    required this.dbHost,
    required this.dbPort,
    required this.dbName,
    required this.dbUser,
    required this.dbPassword,
    required this.dbPoolSize,
  });

  final String appEnv; // Ambiente: development, production...
  final int serverPort; // Porta HTTP em que o servidor escuta.
  final String logLevel; // Nível de log (debug, info...).

  final String dbHost; // Endereço do MySQL.
  final int dbPort; // Porta do MySQL (3307 no host, mapeada pelo Docker).
  final String dbName; // Nome do banco.
  final String dbUser; // Usuário do banco.
  final String dbPassword; // Senha do banco (nunca deve ir para o log).
  final int dbPoolSize; // Máximo de conexões simultâneas no pool.

  // Método getter: acessado como propriedade (`config.producao`), sem ().
  /// Verdadeiro quando a aplicação roda em produção; usado para decidir
  /// o nível de detalhe das mensagens de erro devolvidas ao cliente.
  bool get producao => appEnv == 'production';

  /// Constrói a configuração a partir do ambiente e valida os limites.
  ///
  /// `factory` é um construtor que não é obrigado a criar uma instância nova:
  /// ele executa código antes de devolver o objeto e pode retornar um valor
  /// de cache, uma subclasse ou, como aqui, lançar exceção se algo estiver
  /// errado. Um construtor comum não permite nada disso, porque seu corpo só
  /// roda depois que o objeto já existe.
  factory AppConfig.fromEnv() {
    // Lê cada variável usando o helper adequado (obrigatória, opcional, inteiro).
    final config = AppConfig(
      appEnv: Env.opcional('APP_ENV', 'development'),
      serverPort: Env.inteiro('SERVER_PORT', 8080),
      logLevel: Env.opcional('LOG_LEVEL', 'info'),
      dbHost: Env.obrigatoria('DB_HOST'),
      dbPort: Env.inteiro('DB_PORT', 3307),
      dbName: Env.obrigatoria('DB_NAME'),
      dbUser: Env.obrigatoria('DB_USER'),
      dbPassword: Env.obrigatoria('DB_PASSWORD'),
      dbPoolSize: Env.inteiro('DB_POOL_SIZE', 10),
    );
    // Porta TCP válida vai de 1 a 65535.
    if (config.serverPort < 1 || config.serverPort > 65535) {
      throw StateError('SERVER_PORT fora da faixa válida: ${config.serverPort}');
    }
    // Um pool sem conexões não funcionaria.
    if (config.dbPoolSize < 1) {
      throw StateError('DB_POOL_SIZE deve ser pelo menos 1');
    }
    return config; // Configuração validada.
  }

  // Representação segura para log: a senha nunca é impressa.
  @override
  String toString() {
    return 'AppConfig(appEnv: $appEnv, serverPort: $serverPort, '
        'db: $dbUser@$dbHost:$dbPort/$dbName, pool: $dbPoolSize)';
  }
}

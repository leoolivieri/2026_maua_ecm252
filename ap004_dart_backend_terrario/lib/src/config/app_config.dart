import 'env.dart';

class AppConfig {
  const AppConfig({
    required this.appEnv,
    required this.serverPort,
    required this.logLevel,
    required this.dbHost,
    required this.dbPort,
    required this.dbUser,
    required this.dbPassword,
    required this.dbName,
    required this.dbPoolSize,
  });

  final String appEnv;
  final int serverPort;
  final String logLevel;

  final String dbHost;
  final int dbPort;
  final String dbName;
  final String dbUser;
  final String dbPassword;
  final int dbPoolSize;

  bool get producao => appEnv == 'production';

  factory AppConfig.fromEnv() {
    final config = AppConfig(
      appEnv: Env.opcional('APP_ENV', 'development'),
      serverPort: Env.inteiro('SERVER_PORT', 8080),
      logLevel: Env.opcional('LOG_LEVEL', 'info'),
      dbHost: Env.obrigatoria('DB_HOST'),
      dbPort: Env.inteiro('DB_PORT', 3306),
      dbName: Env.obrigatoria('DB_NAME'),
      dbUser: Env.obrigatoria('DB_USER'),
      dbPassword: Env.obrigatoria('DB_PASSWORD'),
      dbPoolSize: Env.inteiro('DB_POOL_SIZE', 10),
    );

    if (config.serverPort < 1 || config.serverPort > 65535) {
      throw FormatException(
        'SERVER_PORT deve estar entre 1 e 65535, recebido: ${config.serverPort}',
      );
    }

    if (config.dbPoolSize < 1) {
      throw FormatException(
        'DB_POOL_SIZE deve ser maior que 0, recebido: ${config.dbPoolSize}',
      );
    }

    return config;
  }

  /// Representação segura para log: a senha nunca é impressa.
  @override
  String toString() =>
      'AppConfig(appEnv: $appEnv, serverPort: $serverPort, '
      'db: $dbUser@$dbHost:$dbPort/$dbName, pool: $dbPoolSize)';
}

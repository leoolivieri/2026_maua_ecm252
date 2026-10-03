import 'package:mysql_dart/mysql_client.dart';
import 'app_config.dart';

MySQLConnectionPool criarPool (AppConfig config){
  return MySQLConnectionPool(
    host: config.dbHost,
    port: config.dbPort,
    userName: config.dbUser,
    password: config.dbPassword,
    databaseName: config.dbName,
    maxConnections: config.dbPoolSize,
    secure: false, 
    allowPublicKeyRetrieval: true
  );
}

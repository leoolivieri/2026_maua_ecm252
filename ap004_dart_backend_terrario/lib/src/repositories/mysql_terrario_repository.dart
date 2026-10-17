import 'package:mysql_dart/mysql_client.dart'; // Pool, ResultSetRow...
import '../core/erros.dart'; // NaoEncontrado.
import '../models/terrario.dart'; // Terrario e Bioma.
import 'terrario_repository.dart'; // Interface, FiltroTerrario e Pagina.

/// Implementação de [TerrarioRepository] que guarda os dados no MySQL.
class MysqlTerrarioRepository implements TerrarioRepository {
  MysqlTerrarioRepository(this._pool); // Recebe o pool pronto (injeção de dependência).

  final MySQLConnectionPool _pool; // Pool usado em todas as consultas.

  // Colunas lidas em todo SELECT, para não repetir a lista.
  static const String _colunas = 'id, apelido, bioma, umidade_alvo, '
      'volume_litros, data_montagem, criado_em, atualizado_em';

  /// Converte uma linha do resultado SQL em um objeto [Terrario].
  Terrario _mapear(ResultSetRow linha) {
    // assoc() devolve {coluna: valor}. Convertendo tudo para String? fica
    // uniforme. (CORRIGIDO: o original tinha `Sring` em vez de `String`.)
    final dados = linha
        .assoc()
        .map((coluna, valor) => MapEntry(coluna, valor?.toString()));
    return Terrario(
      id: int.parse(dados['id']!), // `!` afirma que não é null.
      apelido: dados['apelido']!,
      bioma: Bioma.porNome(dados['bioma'])!,
      umidadeAlvo: int.parse(dados['umidade_alvo']!),
      volumeLitros: double.parse(dados['volume_litros']!),
      dataMontagem: DateTime.parse(dados['data_montagem']!),
      // tryParse devolve null se o texto for vazio/inválido.
      criadoEm: DateTime.tryParse(dados['criado_em'] ?? ''),
      atualizadoEm: DateTime.tryParse(dados['atualizado_em'] ?? ''),
    ); // CORRIGIDO: faltavam `;` e o fechamento do método e da classe.
  }

  /// Converte o terrário nos parâmetros nomeados usados no SQL (`:apelido`...).
  Map<String, dynamic> _parametros(Terrario t) => {
        'apelido': t.apelido,
        'bioma': t.bioma.name, // Enum -> texto aceito pelo ENUM do MySQL.
        'umidade_alvo': t.umidadeAlvo,
        'volume_litros': t.volumeLitros,
        // Coluna DATE: só a parte aaaa-mm-dd do ISO 8601.
        'data_montagem': t.dataMontagem.toIso8601String().substring(0, 10),
      };

  @override
  Future<Pagina<Terrario>> listar(FiltroTerrario filtro) async {
    final condicoes = <String>[]; // Pedaços do WHERE.
    final params = <String, dynamic>{}; // Valores dos parâmetros.

    if (filtro.bioma != null) {
      condicoes.add('bioma = :bioma');
      params['bioma'] = filtro.bioma!.name;
    }
    if (filtro.umidadeMinima != null) {
      condicoes.add('umidade_alvo >= :umidade');
      params['umidade'] = filtro.umidadeMinima;
    }
    // Junta as condições com AND; sem condições, não há WHERE.
    final where =
        condicoes.isEmpty ? '' : 'WHERE ${condicoes.join(' AND ')}';

    // 1ª consulta: total de registros (para calcular o número de páginas).
    final contagem =
        await _pool.execute('SELECT COUNT(*) AS total FROM terrarios $where', params);
    final total = int.parse(contagem.rows.first.assoc().cast<String, String?>()['total']!);
    // 2ª consulta: só os itens da página pedida.
    final resultado = await _pool.execute(
      'SELECT $_colunas FROM terrarios $where '
      'ORDER BY id LIMIT :limite OFFSET :deslocamento',
      {
        ...params, // Spread: copia os filtros.
        'limite': filtro.tamanhoPagina,
        'deslocamento': filtro.deslocamento,
      },
    );

    return Pagina(
      itens: resultado.rows.map(_mapear).toList(), // Linha -> Terrario.
      total: total,
      paginaAtual: filtro.pagina,
      tamanhoPagina: filtro.tamanhoPagina,
    );
  }

  @override
  Future<Terrario?> buscarPorId(int id) async {
    final resultado = await _pool.execute(
      'SELECT $_colunas FROM terrarios WHERE id = :id', // Parâmetro evita SQL injection.
      {'id': id},
    );
    // Nenhuma linha -> null; senão converte a primeira.
    return resultado.rows.isEmpty ? null : _mapear(resultado.rows.first);
  }

  @override
  Future<Terrario?> buscarPorApelido(String apelido) async {
    final resultado = await _pool.execute(
      'SELECT $_colunas FROM terrarios WHERE apelido = :apelido',
      {'apelido': apelido},
    );
    return resultado.rows.isEmpty ? null : _mapear(resultado.rows.first);
  }

  @override
  Future<Terrario> inserir(Terrario terrario) async {
    final resultado = await _pool.execute(
      'INSERT INTO terrarios (apelido, bioma, umidade_alvo, volume_litros, data_montagem) '
      'VALUES (:apelido, :bioma, :umidade_alvo, :volume_litros, :data_montagem)',
      _parametros(terrario),
    );
    // lastInsertID é BigInt; o id gerado pelo AUTO_INCREMENT.
    final id = resultado.lastInsertID.toInt();
    // Relê do banco para trazer criado_em/atualizado_em preenchidos.
    return (await buscarPorId(id))!;
  }

  @override
  Future<Terrario> atualizar(int id, Terrario terrario) async {
    await _pool.execute(
      'UPDATE terrarios SET apelido = :apelido, bioma = :bioma, '
      'umidade_alvo = :umidade_alvo, volume_litros = :volume_litros, '
      'data_montagem = :data_montagem WHERE id = :id',
      {..._parametros(terrario), 'id': id},
    );
    // Relê para devolver o estado atual (ou falha se o id não existe).
    final atualizado = await buscarPorId(id);
    if (atualizado == null) {
      throw NaoEncontrado('Terrário $id não encontrado');
    }
    return atualizado;
  }

  @override
  Future<bool> remover(int id) async {
    final resultado = await _pool.execute(
      'DELETE FROM terrarios WHERE id = :id',
      {'id': id},
    );
    // Se apagou ao menos uma linha, o terrário existia.
    return resultado.affectedRows > BigInt.zero;
  }
}

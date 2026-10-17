import '../models/terrario.dart'; // Terrario e Bioma.

/// Critérios de busca e paginação para listar terrários.
class FiltroTerrario {
  const FiltroTerrario({
    this.bioma, // Opcional: filtra por bioma.
    this.umidadeMinima, // Opcional: só terrários com umidade >= este valor.
    this.pagina = 1, // Página pedida (começa em 1).
    this.tamanhoPagina = 20, // Itens por página.
  });

  final Bioma? bioma;
  // CORRIGIDO: era `unidadeMinima`; o campo do terrário é umidade.
  final int? umidadeMinima;
  final int pagina;
  final int tamanhoPagina;

  // Quantos registros pular no SQL (OFFSET). Página 1 -> 0, página 2 -> 20...
  int get deslocamento => (pagina - 1) * tamanhoPagina;
}

/// Uma página de resultados. `<T>` torna a classe genérica:
/// serve para `Pagina<Terrario>`, `Pagina<String>` etc.
class Pagina<T> {
  const Pagina({
    required this.itens,
    required this.total,
    // CORRIGIDO: os getters abaixo usavam `paginaAtual`, que não existia.
    required this.paginaAtual,
    required this.tamanhoPagina,
  });

  final List<T> itens; // Itens desta página.
  final int total; // Total de registros que atendem ao filtro (todas as páginas).
  final int paginaAtual; // Número desta página.
  final int tamanhoPagina; // Itens por página.

  // CORRIGIDO: dividia por `itens.length`, que muda na última página
  // (e vale 0 numa página vazia). O certo é dividir pelo tamanho da página.
  int get totalPaginas => total == 0 ? 1 : (total / tamanhoPagina).ceil();

  bool get temProximaPagina => paginaAtual < totalPaginas; // Há página seguinte?
  bool get temPaginaAnterior => paginaAtual > 1; // Há página anterior?
}

/// Contrato de acesso aos terrários. `abstract interface` = só declara
/// métodos; quem implementa (ex.: MysqlTerrarioRepository) define o "como".
abstract interface class TerrarioRepository {
  // CORRIGIDO: havia `buscarTerrarios` e `listar` fazendo o mesmo papel, e
  // `listar` tinha um `>` sobrando. Ficou um só método de listagem.
  Future<Pagina<Terrario>> listar(FiltroTerrario filtro);
  Future<Terrario?> buscarPorId(int id); // null se não existir.
  Future<Terrario?> buscarPorApelido(String apelido); // null se não existir.
  Future<Terrario> inserir(Terrario terrario); // Devolve o terrário já com id.
  // CORRIGIDO: `Terrrario` estava com 3 "r".
  Future<Terrario> atualizar(int id, Terrario terrario);
  Future<bool> remover(int id); // true se algo foi removido.
}

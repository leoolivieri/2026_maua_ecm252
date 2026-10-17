/// Classe base de todas as falhas previsíveis da aplicação.
// `sealed`: todas as subclasses precisam estar neste arquivo, então o
// compilador sabe a lista completa e um `switch` sobre ErroApp fica exaustivo.
// `implements Exception` permite lançá-la com `throw`.
sealed class ErroApp implements Exception {
  const ErroApp(this.mensagem); // Construtor const que guarda a mensagem.
  final String mensagem; // Texto explicando o erro.

  // `runtimeType` é o nome da subclasse real (ex.: NaoEncontrado).
  @override
  String toString() => '$runtimeType: $mensagem';
}

/// O recurso pedido não existe. Vira 404.
class NaoEncontrado extends ErroApp {
  // `super.mensagem` repassa o argumento direto ao construtor da classe-mãe.
  const NaoEncontrado(super.mensagem);
}

/// Requisição atendida, mas viola uma regra de negócio. Vira 422.
/// O mapa [campos] associa o nome de cada campo inválido à sua explicação,
/// permitindo que o formulário do cliente destaque exatamente o que corrigir.
class ErroValidacao extends ErroApp {
  // `[ ... ]` = parâmetro posicional opcional, com mapa vazio como padrão.
  const ErroValidacao(super.mensagem, [this.campos = const {}]);
  final Map<String, String> campos; // campo -> motivo do erro.
}

/// A operação conflita com o estado atual dos dados. Vira 409 (Conflict).
class Conflito extends ErroApp {
  const Conflito(super.mensagem);
}

/// O corpo enviado não pôde ser interpretado. Vira 400.
class RequisicaoInvalida extends ErroApp {
  const RequisicaoInvalida(super.mensagem);
}

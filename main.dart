void main() {
  Passagem passagem = Passagem();

  Passagem passagemAll = Passagem.all(
    "ABC123",
    passageiro: Passageiro(),
    plataforma: PlataformaVenda(),
    atendente: Atendente(),
    observacoes: "Passagem padrão",
  );

  PassagemPrimeiraClasse primeiraClasse = PassagemPrimeiraClasse(
    loungeAcesso: "Sala VIP",
    codigoLocalizador: "PC123",
    passageiro: Passageiro(),
    plataforma: PlataformaVenda(),
    atendente: Atendente(),
    observacoes: "Primeira classe",
  );

  passagem.emitirPassagem();
  passagem.cancelarPassagem();

  passagemAll.atualizarPassagem();
  passagemAll.consultarPassagem("ABC123");

  primeiraClasse.atualizarPassagem();
}

class Passageiro {
  String? nome;
  String? cpf;
  String? rg;
  String? email;
  String? celular;
}

class PlataformaVenda {
  int? codigoCanal;
  String? nomeCanal;
}

class Atendente {
  String? nome;
  String? matricula;
  String? cargo;
  String? email;
  String? celular;
  double? salario;
}

class Passagem {
  String? _codigoLocalizador = "";
  Passageiro? passageiro;
  PlataformaVenda? plataforma;
  Atendente? atendente;
  String? observacoes;

  Passagem();

  Passagem(
    this._codigoLocalizador,
    this.passageiro,
    this.plataforma,
    this.atendente,
    this.observacoes,
  );

  Passagem.somenteCodigo(this._codigoLocalizador);

  Passagem.completa(
    this._codigoLocalizador,
    this.passageiro,
    this.plataforma,
    this.atendente,
    this.observacoes,
  );

  Passagem.codigoPassageiro({
    this._codigoLocalizador,
    this.passageiro,
  });

  Passagem.all(
    this._codigoLocalizador, {
    required this.passageiro,
    required this.plataforma,
    required this.atendente,
    this.observacoes,
  });

  String? get codigoLocalizador => _codigoLocalizador;

  set codigoLocalizador(String? codigoLocalizador) {
    if (codigoLocalizador == null || codigoLocalizador.isEmpty) {
      print("Código localizador de passagem $codigoLocalizador é inválido!");
      return;
    }

    _codigoLocalizador = codigoLocalizador;
  }

  void emitirPassagem() {
    print("Passagem emitida com sucesso!");
  }

  bool cancelarPassagem() {
    print("Passagem cancelada com sucesso!");
    return true;
  }

  void atualizarPassagem() {
    print("Passagem atualizada com sucesso");
  }

  Passagem consultarPassagem(String codigo) {
    print("Passagem consultada com sucesso");
    return Passagem();
  }
}

class PassagemPrimeiraClasse extends Passagem with Logger, Auditoria {
  String? loungeAcesso;

  PassagemPrimeiraClasse({
    required this.loungeAcesso,
    String? codigoLocalizador,
    Passageiro? passageiro,
    PlataformaVenda? plataforma,
    Atendente? atendente,
    String? observacoes,
  }) : super.all(
          codigoLocalizador,
          passageiro: passageiro,
          plataforma: plataforma,
          atendente: atendente,
          observacoes: observacoes,
        );

  @override
  void atualizarPassagem() {
    print("Passagem de primeira classe atualizada com sucesso");

    log("Alteração realizada pelo: ${atendente?.nome ?? 'Não Informado'}");

    auditar("Verificação de segurança realizada para a Primeira Classe.");
  }
}

mixin Logger {
  void log(String message) {
    print(message);
  }
}

mixin Auditoria {
  void auditar(String message) {
    print("[Auditoria]: $message");
  }
}

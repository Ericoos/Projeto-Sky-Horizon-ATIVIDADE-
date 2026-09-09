class Passageiro {
  String? nome;
  String? cpf;
  String? rg;
  String? email;
  String? celular;

  Passageiro({this.nome, this.cpf, this.rg, this.email, this.celular});
}

class PlataformaVenda {
  int? codigoCanal;
  String? nomeCanal;

  PlataformaVenda({this.codigoCanal, this.nomeCanal});
}

class Atendente {
  String? nome;
  String? matricula;
  String? cargo;
  String? email;
  String? celular;
  double? salario;

  Atendente({this.nome, this.matricula, this.cargo, this.email, this.celular, this.salario});
}

mixin Logger {
  void log(String mensagem) {
    print("[Log]: $mensagem");
  }
}

mixin Auditoria {
  void auditar(String mensagem) {
    print("[Auditoria]: $mensagem");
  }
}

class Passagem {
  String? _codigoLocalizador = '';

  Passageiro? passageiro;
  PlataformaVenda? plataforma;
  Atendente? atendente;
  String? observacoes;

  Passagem();

  Passagem.somenteCodigo(String codigoLocalizador) {
    this.codigoLocalizador = codigoLocalizador;
  }

  Passagem.completa(String? codigoLocalizador, this.passageiro, this.plataforma, this.atendente, this.observacoes) {
    this.codigoLocalizador = codigoLocalizador;
  }

  Passagem.codigoEPassageiro({String? codigoLocalizador, this.passageiro}) {
    this.codigoLocalizador = codigoLocalizador;
  }

  Passagem.all(String? codigoLocalizador, {required this.passageiro, required this.plataforma, required this.atendente, this.observacoes}) {
    this.codigoLocalizador = codigoLocalizador;
  }

  String? getCodigoLocalizador() {
    return _codigoLocalizador;
  }

  void setCodigoLocalizador(String? codigoLocalizador) {
    if (codigoLocalizador == null || codigoLocalizador.isEmpty) {
      print("Código localizador de passagem inválido!");
      return;
    }
    _codigoLocalizador = codigoLocalizador;
  }

  String? get codigoLocalizador => _codigoLocalizador;

  set codigoLocalizador(String? codigoLocalizador) {
    if (codigoLocalizador == null || codigoLocalizador.isEmpty) {
      print("Código localizador de passagem inválido!");
      return;
    }
    _codigoLocalizador = codigoLocalizador;
  }

  void EmitirPassagem() {
    print("Passagem emitida com sucesso!");
  }

  bool CancelarPassagem() {
    print("Passagem cancelada com sucesso!");
    return true;
  }

  void AtualizarPassagem() {
    print("Passagem atualizada com sucesso!");
  }

  Passagem ConsultarPassagem(String codigo) {
    print("Passagem consultada com sucesso!");
    return Passagem();
  }
}

class PassagemPrimeiraClasse extends Passagem with Logger, Auditoria {
  String? loungeAcesso;

  PassagemPrimeiraClasse(String? codigoLocalizador, {required this.loungeAcesso, required Passageiro? passageiro, required PlataformaVenda? plataforma, required Atendente? atendente, String? observacoes})
      : super.all(codigoLocalizador, passageiro: passageiro, plataforma: plataforma, atendente: atendente, observacoes: observacoes);

  @override
  void AtualizarPassagem() {
    print("Passagem de Primeira Classe atualizada com sucesso!");
    log("Alteração realizada pelo atendente: ${super.atendente?.nome ?? 'Não informado'}");
    auditar("Verificação de segurança realizada para a Primeira Classe.");
  }
}

void main() {
  print("=== SISTEMA SKYHORIZON AIRLINES ===\n");

  var p1 = Passageiro(nome: "Carlos Silva", cpf: "123.456.789-00", rg: "45.678.901-2", email: "carlos.silva@email.com", celular: "(11) 98888-1234");

  var canal = PlataformaVenda(codigoCanal: 101, nomeCanal: "App SkyHorizon");

  var fun1 = Atendente(nome: "Mariana Souza", matricula: "EMP987", cargo: "Atendente de Balcão", email: "mariana.souza@skyhorizon.com", celular: "(11) 97777-4321", salario: 4200.00);

  print("--- 1. Passagem Padrão ---");
  var passagem1 = Passagem();
  passagem1.codigoLocalizador = "";
  passagem1.codigoLocalizador = "SKY12345";
  passagem1.passageiro = p1;
  passagem1.EmitirPassagem();
  print("Código cadastrado (getter nativo): ${passagem1.codigoLocalizador}");
  print("Código cadastrado (getter Ex.5): ${passagem1.getCodigoLocalizador()}\n");

  print("--- 2. Construtores Nomeados ---");
  var passagem2 = Passagem.somenteCodigo("SKY22222");
  print("Somente código: ${passagem2.codigoLocalizador}");

  var passagem3 = Passagem.codigoEPassageiro(codigoLocalizador: "SKY33333", passageiro: p1);
  print("Código e passageiro: ${passagem3.codigoLocalizador} - ${passagem3.passageiro?.nome}\n");

  print("--- 3. Passagem Completa (Passagem.all) ---");
  var passagem4 = Passagem.all("SKY67890", passageiro: p1, plataforma: canal, atendente: fun1, observacoes: "Passageiro com preferência por assento na janela");
  passagem4.AtualizarPassagem();
  print("Atendente: ${passagem4.atendente?.nome}");
  print("Canal de venda: ${passagem4.plataforma?.nomeCanal}");
  passagem4.ConsultarPassagem("SKY67890");
  print("");

  print("--- 4. Passagem Primeira Classe (VIP) ---");
  var passagemVip = PassagemPrimeiraClasse("VIP99999", loungeAcesso: "Lounge Star Alliance VIP", passageiro: p1, plataforma: canal, atendente: fun1, observacoes: "Champagne de boas-vindas solicitado");

  print("Localizador: ${passagemVip.codigoLocalizador}");
  print("Lounge acessível: ${passagemVip.loungeAcesso}");
  passagemVip.EmitirPassagem();
  passagemVip.AtualizarPassagem();
  passagemVip.CancelarPassagem();
  print("");

  print("--- 5. Polimorfismo ---");
  List<Passagem> passagens = [passagem1, passagem4, passagemVip];
  for (var p in passagens) {
    p.AtualizarPassagem();
  }
}
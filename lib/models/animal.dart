class Animal {
  String? id;
  String? nomeAnimal;
  String? codigoSisbov;
  String? idEletronico; 
  String? lotePiqueteAtual; 
  String? dataNascimento; 

  String? sexo;
  String? raca; 
  String? corPelagem; 
  String? marcacoesFisicas; 
  String? origem; 
  String? statusReprodutivo; 

  String? idPai;
  String? nomePai;
  String? idMae;
  String? nomeMae;

  double? alturaCernelha;
  double? circunferenciaToracica;
  int? escoreCorporal; 
  double? perimetroEscrotal;

  double? valorAquisicao;
  String? statusVenda; 
  String? observacoes;

  String? dataCadastro;
  String? dataAtualizacao;
  
  double? latitude;
  double? longitude;
  String? ultimaLocalizacao;
  String? statusLocalizacao; 

  Animal({
    this.id,
    this.nomeAnimal,
    this.codigoSisbov,
    this.idEletronico,
    this.lotePiqueteAtual,
    this.dataNascimento,
    this.sexo,
    this.raca,
    this.corPelagem,
    this.marcacoesFisicas,
    this.origem,
    this.statusReprodutivo,
    this.idPai,
    this.nomePai,
    this.idMae,
    this.nomeMae,
    this.alturaCernelha,
    this.circunferenciaToracica,
    this.escoreCorporal,
    this.perimetroEscrotal,
    this.valorAquisicao,
    this.statusVenda,
    this.observacoes,
    this.dataCadastro,
    this.dataAtualizacao,
    this.latitude,
    this.longitude,
    this.ultimaLocalizacao,
    this.statusLocalizacao,
  });

  factory Animal.fromMap(Map<String, dynamic> map) {
    return Animal(
      id: map['id'],
      nomeAnimal: map['nomeAnimal'],
      codigoSisbov: map['codigoSisbov'],
      idEletronico: map['idEletronico'],
      lotePiqueteAtual: map['lotePiqueteAtual'],
      dataNascimento: map['dataNascimento'],
      sexo: map['sexo'],
      raca: map['raca'],
      corPelagem: map['corPelagem'],
      marcacoesFisicas: map['marcacoesFisicas'],
      origem: map['origem'],
      statusReprodutivo: map['statusReprodutivo'],
      idPai: map['idPai'],
      nomePai: map['nomePai'],
      idMae: map['idMae'],
      nomeMae: map['nomeMae'],
      alturaCernelha: map['alturaCernelha']?.toDouble(),
      circunferenciaToracica: map['circunferenciaToracica']?.toDouble(),
      escoreCorporal: map['escoreCorporal'],
      perimetroEscrotal: map['perimetroEscrotal']?.toDouble(),
      valorAquisicao: map['valorAquisicao']?.toDouble(),
      statusVenda: map['statusVenda'],
      observacoes: map['observacoes'],
      dataCadastro: map['dataCadastro'],
      dataAtualizacao: map['dataAtualizacao'],
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
      ultimaLocalizacao: map['ultimaLocalizacao'],
      statusLocalizacao: map['statusLocalizacao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeAnimal': nomeAnimal,
      'codigoSisbov': codigoSisbov,
      'idEletronico': idEletronico,
      'lotePiqueteAtual': lotePiqueteAtual,
      'dataNascimento': dataNascimento,
      'sexo': sexo,
      'raca': raca,
      'corPelagem': corPelagem,
      'marcacoesFisicas': marcacoesFisicas,
      'origem': origem,
      'statusReprodutivo': statusReprodutivo,
      'idPai': idPai,
      'nomePai': nomePai,
      'idMae': idMae,
      'nomeMae': nomeMae,
      'alturaCernelha': alturaCernelha,
      'circunferenciaToracica': circunferenciaToracica,
      'escoreCorporal': escoreCorporal,
      'perimetroEscrotal': perimetroEscrotal,
      'valorAquisicao': valorAquisicao,
      'statusVenda': statusVenda,
      'observacoes': observacoes,
      'dataCadastro': dataCadastro,
      'dataAtualizacao': dataAtualizacao,
      'latitude': latitude,
      'longitude': longitude,
      'ultimaLocalizacao': ultimaLocalizacao,
      'statusLocalizacao': statusLocalizacao,
    };
  }

  Animal copyWith({
    String? id,
    String? nomeAnimal,
    String? codigoSisbov,
    String? idEletronico,
    String? lotePiqueteAtual,
    String? dataNascimento,
    String? sexo,
    String? raca,
    String? corPelagem,
    String? marcacoesFisicas,
    String? origem,
    String? statusReprodutivo,
    String? idPai,
    String? nomePai,
    String? idMae,
    String? nomeMae,
    double? alturaCernelha,
    double? circunferenciaToracica,
    int? escoreCorporal,
    double? perimetroEscrotal,
    double? valorAquisicao,
    String? statusVenda,
    String? observacoes,
    String? dataCadastro,
    String? dataAtualizacao,
    double? latitude,
    double? longitude,
    String? ultimaLocalizacao,
    String? statusLocalizacao,
  }) {
    return Animal(
      id: id ?? this.id,
      nomeAnimal: nomeAnimal ?? this.nomeAnimal,
      codigoSisbov: codigoSisbov ?? this.codigoSisbov,
      idEletronico: idEletronico ?? this.idEletronico,
      lotePiqueteAtual: lotePiqueteAtual ?? this.lotePiqueteAtual,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      sexo: sexo ?? this.sexo,
      raca: raca ?? this.raca,
      corPelagem: corPelagem ?? this.corPelagem,
      marcacoesFisicas: marcacoesFisicas ?? this.marcacoesFisicas,
      origem: origem ?? this.origem,
      statusReprodutivo: statusReprodutivo ?? this.statusReprodutivo,
      idPai: idPai ?? this.idPai,
      nomePai: nomePai ?? this.nomePai,
      idMae: idMae ?? this.idMae,
      nomeMae: nomeMae ?? this.nomeMae,
      alturaCernelha: alturaCernelha ?? this.alturaCernelha,
      circunferenciaToracica:
          circunferenciaToracica ?? this.circunferenciaToracica,
      escoreCorporal: escoreCorporal ?? this.escoreCorporal,
      perimetroEscrotal: perimetroEscrotal ?? this.perimetroEscrotal,
      valorAquisicao: valorAquisicao ?? this.valorAquisicao,
      statusVenda: statusVenda ?? this.statusVenda,
      observacoes: observacoes ?? this.observacoes,
      dataCadastro: dataCadastro ?? this.dataCadastro,
      dataAtualizacao: dataAtualizacao ?? this.dataAtualizacao,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      ultimaLocalizacao: ultimaLocalizacao ?? this.ultimaLocalizacao,
      statusLocalizacao: statusLocalizacao ?? this.statusLocalizacao,
    );
  }

  bool isValid() {
    return idEletronico != null &&
        idEletronico!.isNotEmpty &&
        lotePiqueteAtual != null &&
        lotePiqueteAtual!.isNotEmpty &&
        dataNascimento != null &&
        dataNascimento!.isNotEmpty &&
        sexo != null &&
        sexo!.isNotEmpty &&
        raca != null &&
        raca!.isNotEmpty &&
        corPelagem != null &&
        corPelagem!.isNotEmpty &&
        marcacoesFisicas != null &&
        marcacoesFisicas!.isNotEmpty &&
        origem != null &&
        origem!.isNotEmpty &&
        statusReprodutivo != null &&
        statusReprodutivo!.isNotEmpty &&
        statusVenda != null &&
        statusVenda!.isNotEmpty;
  }

  List<String> getMissingRequiredFields() {
    List<String> missing = [];

    if (idEletronico == null || idEletronico!.isEmpty) {
      missing.add('ID Eletrônico');
    }
    if (lotePiqueteAtual == null || lotePiqueteAtual!.isEmpty) {
      missing.add('Lote/Piquete Atual');
    }
    if (dataNascimento == null || dataNascimento!.isEmpty) {
      missing.add('Data de Nascimento');
    }
    if (sexo == null || sexo!.isEmpty) {
      missing.add('Sexo');
    }
    if (raca == null || raca!.isEmpty) {
      missing.add('Raça');
    }
    if (corPelagem == null || corPelagem!.isEmpty) {
      missing.add('Cor da Pelagem');
    }
    if (marcacoesFisicas == null || marcacoesFisicas!.isEmpty) {
      missing.add('Marcações Físicas');
    }
    if (origem == null || origem!.isEmpty) {
      missing.add('Origem');
    }
    if (statusReprodutivo == null || statusReprodutivo!.isEmpty) {
      missing.add('Status Reprodutivo');
    }
    if (statusVenda == null || statusVenda!.isEmpty) {
      missing.add('Status de Venda');
    }

    return missing;
  }

  @override
  String toString() {
    return 'Animal{id: $id, nomeAnimal: $nomeAnimal, idEletronico: $idEletronico, lotePiqueteAtual: $lotePiqueteAtual}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Animal && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

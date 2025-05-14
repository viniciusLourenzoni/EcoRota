class AbastecimentoModel {
  int? id;
  String data;
  double litros;
  double preco;
  int odometro;
  String posto;

  AbastecimentoModel({
    this.id,
    required this.data,
    required this.litros,
    required this.preco,
    required this.odometro,
    required this.posto,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data,
      'litros': litros,
      'preco': preco,
      'odometro': odometro,
      'posto': posto,
    };
  }

  factory AbastecimentoModel.fromMap(Map<String, dynamic> map) {
    return AbastecimentoModel(
      id: map['id'],
      data: map['data'],
      litros: map['litros'],
      preco: map['preco'],
      odometro: map['odometro'],
      posto: map['posto'],
    );
  }
}

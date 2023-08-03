class MoedaModel {
  String icone;
  String nome;
  String sigla; 
  double cotacao;

  MoedaModel({
    required this.icone,
    required this.nome,
    required this.sigla,
    required this.cotacao
  });

  MoedaModel.tomap(Map<String, dynamic> map) :
    icone = map['icone'],
    nome = map['nome'],
    sigla = map['sigla'],
    cotacao = map['cotacao'];
  
}
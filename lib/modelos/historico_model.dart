class HistoricoModel {
  DateTime dataOperacao;
  String sigla;
  String tipoOperacao;
  double quantidade;
  double valor;

  HistoricoModel({
    required this.dataOperacao,
    required this.sigla,
    required this.tipoOperacao,
    required this.quantidade,
    required this.valor,
  });
  
}
class RestauranteInfo {
  final String nome;
  final String enderecoTexto;
  final String? faixaPreco;
  final String? abreEm;
  final String? fechaEm;

  const RestauranteInfo({
    required this.nome,
    required this.enderecoTexto,
    this.faixaPreco,
    this.abreEm,
    this.fechaEm,
  });

  factory RestauranteInfo.fromJson(Map<String, dynamic> json) {
    return RestauranteInfo(
      nome: (json['nome'] ?? '').toString(),
      enderecoTexto: (json['endereco_texto'] ?? '').toString(),
      faixaPreco: json['faixa_preco']?.toString(),
      abreEm: json['abre_em']?.toString(),
      fechaEm: json['fecha_em']?.toString(),
    );
  }
}

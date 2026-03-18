class TagItem {
  final String categoria;
  final String nome;
  final String slug;

  TagItem({required this.categoria, required this.nome, required this.slug});

  factory TagItem.fromJson(Map<String, dynamic> json) {
    return TagItem(
      categoria: (json["categoria"] ?? "").toString(),
      nome: (json["nome"] ?? "").toString(),
      slug: (json["slug"] ?? "").toString(),
    );
  }
}

class Datas{
  final int idDatas;
  final String nim;
  final String tittleIssues;
  final String description;
  final int? rating;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Datas({
    required this.idDatas,
    required this.nim,
    required this.tittleIssues,
    required this.description,
    this.rating,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Datas.fromJson(Map<String, dynamic> json) {
    return Datas(
      idDatas: json["id_customer_service"] as int,
      nim: json["nim"] as String,
      tittleIssues: json["title_issues"] as String,
      description: json["description_issues"] as String,
      rating: json["rating"] as int,
      imageUrl: json["image_url"] as String,
      createdAt: DateTime.parse(json["created_at"] as String),
      updatedAt: DateTime.parse(json["updated_at"] as String),
      deletedAt: json["deleted_at"] != null ? DateTime.parse(json["deleted_at"] as String) : null,
    );
  }
}
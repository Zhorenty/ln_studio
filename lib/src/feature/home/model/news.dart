class NewsModel {
  NewsModel({
    required this.id,
    required this.photo,
    required this.title,
    required this.description,
    required this.isDeleted,
  });

  ///
  final int id;

  ///
  final String? photo;

  ///
  final String title;

  ///
  final String description;

  ///
  final bool isDeleted;

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      photo: json['photo'],
      title: json['title'],
      description: json['description'],
      isDeleted: json['is_deleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photo': photo,
      'title': title,
      'description': description,
      'is_deleted': isDeleted,
    };
  }
}

class NewsModel {
  final int id;
  final String cover;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  String coverUrl; // New field

  NewsModel({
    required this.id,
    required this.cover,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.coverUrl = '', // New field in constructor
  });

  // Copy constructor to create a new instance with updated fields
  NewsModel copyWith({
    int? id,
    String? cover,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? coverUrl,
  }) {
    return NewsModel(
      id: id ?? this.id,
      cover: cover ?? this.cover,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      coverUrl: coverUrl ?? this.coverUrl,
    );
  }

  // Deserialization from JSON
  NewsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        cover = json['cover'] ?? '',
        title = json['title'] ?? '',
        description = json['description'] ?? '',
        createdAt = DateTime.tryParse(json['created_at'] ?? '1970-01-01') ??
            DateTime(1970, 1, 1),
        updatedAt = DateTime.tryParse(json['updated_at'] ?? '1970-01-01') ??
            DateTime(1970, 1, 1),
        coverUrl = json['cover_url'] ?? '';
        // coverUrl = (json['cover_url'] as String?)?.replaceAll('//', '/') ?? ''; 

  // Serialization to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'cover': cover,
        'title': title,
        'description': description,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'cover_url': coverUrl, // New field in serialization
      };
}

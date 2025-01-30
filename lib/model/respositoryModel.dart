// ignore: file_names
class RepositoryModel {
  final int id;
  final String name;
  final String description;
  final int stars;
  final String owner;
  final String avatarUrl;

  RepositoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.stars,
    required this.owner,
    required this.avatarUrl,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      stars: json['stargazers_count'],
      owner: json['owner']['login'],
      avatarUrl: json['owner']['avatar_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'stars': stars,
      'owner': owner,
      'avatarUrl': avatarUrl,
    };
  }

  static RepositoryModel fromMap(Map<String, dynamic> map) {
    return RepositoryModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      stars: map['stars'],
      owner: map['owner'],
      avatarUrl: map['avatarUrl'],
    );
  }
}

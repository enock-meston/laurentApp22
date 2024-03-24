class CourseModel {
  final int id;
  final String title;
  final String youtubeUrlLink;
  final String description;
  final String status;

  CourseModel({
    required this.id,
    required this.title,
    required this.youtubeUrlLink,
    required this.description,
    required this.status,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      youtubeUrlLink: json['youtubeUrlLink'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'youtubeUrlLink': youtubeUrlLink,
      'description': description,
      'status': status,
    };
  }
}

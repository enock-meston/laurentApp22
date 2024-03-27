class RecentCourse {
  int id;
  String title;
  String youtubeUrlLink;
  String description;

  RecentCourse({
    required this.id,
    required this.title,
    required this.youtubeUrlLink,
    required this.description,
  });

  factory RecentCourse.fromJson(Map<String, dynamic> json) {
    return RecentCourse(
      id: json['id'],
      title: json['title'],
      youtubeUrlLink: json['youtubeUrlLink'],
      description: json['description'],
    );
  }
}

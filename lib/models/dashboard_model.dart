class DashboardData {
  final int countIsomo;
  final int countQuestionAnswer;
  final int countSubscriptions;

  DashboardData({
    required this.countIsomo,
    required this.countQuestionAnswer,
    required this.countSubscriptions,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      countIsomo: json['CountIsomo'],
      countQuestionAnswer: json['CountQuestionAnswer'],
      countSubscriptions: json['CountSubscriptions'],
    );
  }
}

class SubscriptionModel {
  final int id;
  final String title;
  final String price;
  final String details;
  final String status;

  SubscriptionModel({
    required this.id,
    required this.title,
    required this.price,
    required this.details,
    required this.status,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      details: json['details'],
      status: json['status'],
    );
  }
}

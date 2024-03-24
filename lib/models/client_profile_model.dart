class ClientProfileModel {
  int? id;
  String? names;
  String? phoneNumber;
  String? email;
  String? password;
  String? status;

  ClientProfileModel({
    this.id,
    this.names,
    this.phoneNumber,
    this.email,
    this.password,
    this.status,
  });

  ClientProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    names = json['names'] ?? '';
    phoneNumber = json['phone_number'] ?? '';
    email = json['email'] ?? '';
    password = json['password'] ?? '';
    status = json['status'] ?? '';
    }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['names'] = this.names;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    data['status'] = this.status;
    return data;
  }
}

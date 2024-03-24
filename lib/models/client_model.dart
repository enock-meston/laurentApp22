class ClientModel {
  String client_names;
  String client_email;
  String client_phone;
  String client_password;

  ClientModel(
    this.client_names,
    this.client_email,
    this.client_phone,
    this.client_password,
  );

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
      json['names'] as String,
      json['email'] as String,
      json['phone_number'] as String,
      json['password'] as String);
  Map<String, dynamic> toJson() => {
        'names': client_names.toString(),
        'email': client_email.toString(),
        'phone_number': client_phone.toString(),
        'password': client_password.toString()
      };
}

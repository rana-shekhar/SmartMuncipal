class UserModel {
  String? name;
  String? phone;
  String? state;
  String? city;
  String? address;
  String? ward;
  DateTime? createdAt;

  UserModel({
    this.name,
    this.phone,
    this.state,
    this.city,
    this.address,
    this.ward,
    this.createdAt,
  });

  // Convert Object to JSON
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "phone": phone,
      "state": state,
      "city": city,
      "address": address,
      "ward": ward,
      "createdAt": createdAt ?? DateTime.now(),
    };
  }
}

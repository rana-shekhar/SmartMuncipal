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

class Complaint {
  String city;
  String ward;
  String address;
  String topic;
  String description;
  String id;

  Complaint({
    required this.city,
    required this.ward,
    required this.address,
    required this.topic,
    required this.description,
    required this.id, String? imageUrl,
  });
  Map<String, dynamic> toMap() {
    return {
      "city": city,
      "ward": ward,
      "address": address,
      "topic": topic,
      "description": description,
      "id": id,
    };
  }
}

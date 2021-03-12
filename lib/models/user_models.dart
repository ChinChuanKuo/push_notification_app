class UserModels {
  String id;
  String name;
  String email;

  UserModels({
    this.id,
    this.name,
    this.email,
  });

  UserModels.fromData(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        email = data['email'];

  static UserModels fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return UserModels(
      id: map["id"],
      name: map["name"],
      email: map["email"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}

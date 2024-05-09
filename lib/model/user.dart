class User {
  int? id;
  int? idRole;
  String name;
  String email;
  String? password;
  String phone;
  String? token;

  User({
    this.id,
    this.idRole,
    required this.name,
    required this.email,
    this.password,
    required this.phone,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      idRole: json['id_role'],
      name: json['nama'],
      email: json['email'],
      phone: json['no_telepon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_role': idRole,
      'nama': name,
      'email': email,
      'no_telepon': phone,
    };
  }
}

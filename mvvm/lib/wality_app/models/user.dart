
class User {
  String? username;
  String? email;
  String? password;

  User({required this.username, required this.email, required this.password});

  factory User.fromMap(Map<String, dynamic> data, String documentId) {
    return User(
      username: data['name'] ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}

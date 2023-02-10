class User {
  int? id;
  String? name;
  String? image;
  String? email;
  String? token;

  User({this.id, this.name, this.image, this.email, this.token});

  factory User.formJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['id'],
      image: json['user']['id'],
      email: json['user']['id'],
      token: json['user']['id'],
    );
  }
}

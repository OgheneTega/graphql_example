class User {
  String? bio;
  String? username;
  int? id;

  User(this.bio, this.username, this.id);

  User.fromJson(Map<String, dynamic> json) {
    bio = json['bio'];
    username = json['username'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bio'] = bio;
    data['username'] = username;
    data['id'] = id;
    return data;
  }
}

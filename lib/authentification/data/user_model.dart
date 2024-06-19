class UserModel {
  String username;
  String email;
  String name;
  String bio;
  //String avatar;

  UserModel(
      {required this.username,
      required this.email,
      required this.name,
      required this.bio});

  UserModel.fromJson(Map<String, dynamic> parsedJSON)
      : username = parsedJSON['username'],
        email = parsedJSON['email'],
        name = parsedJSON['name'],
        bio = parsedJSON['bio'];
  //avatar = parsedJSON['avatar'];

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'name': name,
      'bio': bio,
      //'avatar': avatar,
    };
  }
}

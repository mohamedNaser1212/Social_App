class UserModel {
  String? uId;
  String? name;
  String? email;
  String? password;
  String? image;
  String? cover;
  String? bio;
  String? phone;
  bool? isEmailVerified;

  UserModel({
    this.uId,
    this.password,
    this.name,
    this.email,
    this.image,
    this.cover,
    this.bio,
    this.phone,
    this.isEmailVerified ,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'];
    image = json['image'];
    password = json['password'];
    cover = json['cover'];
    name = json['name'];
    uId = json['uId'];
    bio = json['bio'];
    phone = json['phone'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'cover': cover,
      'password': password,
      'uId': uId,
      'bio': bio,
      'phone': phone,
      'isEmailVerified': isEmailVerified,
    };
  }
}
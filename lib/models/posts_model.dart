class PostModel {
  String? uId;
  String? name;
  String? dateTime;
  String? image;
  String? text;
  String? postImage;


  PostModel({
    this.uId,
    this.name,
    this.image,
this.text,
    this.dateTime,
    this.postImage,

  });

  PostModel.fromJson(Map<String, dynamic>? json) {

    image = json?['image'];
    text = json?['text'];
    dateTime= json?['dateTime'];
    postImage = json?['postImage'];
    name = json?['name'];
    uId = json?['uId'];

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'text': text,
      'image': image,
      'dateTime': dateTime,
      'postImage': postImage,
      'uId': uId,

    };
  }
}
class CommentModel{
  String? text;
  String? dateTime;
  String? userId;
  String? userImage;
  String? name;

  CommentModel({
    this.name,
    this.text,
    this.dateTime,
    this.userId,
    this.userImage,
});

  CommentModel.fromJson(Map<String,dynamic>json){
    text=json["text"];
    name=json["name"];
    dateTime=json["dateTime"];
    userId=json["userId"];
    userImage=json["userImage"];
  }

  Map<String,dynamic> toMap(){
    return {
      "text":text,
      "name":name,
      "dateTime":dateTime,
      "userId":userId,
      "userImage":userImage
    };
}
}
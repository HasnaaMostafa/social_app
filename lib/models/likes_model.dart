class LikeModel{
  String? name;
  String? image;
  String? userId;

  LikeModel(
      this.userId,
      this.name,
      this.image,
      );

  LikeModel.fromJson(Map<String,dynamic>json){
    name=json["name"];
    image=json["image"];
    userId=json["userId"];
  }

  Map<String,dynamic> toMap(){
    return{
      "name":name,
      "image": image,
      "userId":userId,
    };
  }

}
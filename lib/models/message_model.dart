class MessageModel {
  String? senderId;
  String? receiverId;
  String? text;
  String? dateTime;
  String? chatImage;
  List<String>? receiverIds;

  MessageModel(
      {this.senderId,
      this.text,
      this.receiverId,
      this.dateTime,
      this.chatImage,
      this.receiverIds});

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json["senderId"];
    text = json["text"];
    receiverId = json["receiverId"];
    dateTime = json["dateTime"];
    chatImage = json["chatImage"];
    receiverIds = json["receiverIds"];
  }

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "text": text,
      "receiverId": receiverId,
      "dateTime": dateTime,
      "chatImage": chatImage,
      "receiverIds": receiverIds,
    };
  }
}

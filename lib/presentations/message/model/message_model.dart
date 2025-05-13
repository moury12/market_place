class MessageModel {
  String? sId;
  String? conversationId;
  String? message;
  String? img;
  String? sender;
  String? createdAt;
  String? updatedAt;
  int? iV;

  MessageModel(
      {this.sId,
        this.conversationId,
        this.message,
        this.img,
        this.sender,
        this.createdAt,
        this.updatedAt,
        this.iV});

  MessageModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    conversationId = json['conversation_id'];
    message = json['message'];
    img = json['img'];
    sender = json['sender'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['conversation_id'] = conversationId;
    data['message'] = message;
    data['img'] = img;
    data['sender'] = sender;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

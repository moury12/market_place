class ConversationModel {
  String? sId;
  List<Users>? users;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ConversationModel(
      {this.sId, this.users, this.createdAt, this.updatedAt, this.iV});

  ConversationModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Users {
  String? sId;
  String? name;
  String? email;
  String? img;

  Users({this.sId, this.name, this.email, this.img});

  Users.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['img'] = img;
    return data;
  }
}

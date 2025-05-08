
class ProductModel {
  String? sId;
  String? name;
  String? price;
  String? condition;
  bool? isFavorite;
  String? img;
  String? categoryName;

  ProductModel(
      {this.sId,
        this.name,
        this.price,
        this.condition,
        this.isFavorite,
        this.img,
        this.categoryName});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString()=='null'?'n/a':json['_id'].toString();
    name = json['name'].toString()=='null'?'n/a':json['name'].toString();
    price = json['price'].toString()=='null'?'n/a':json['price'].toString();
    condition = json['condition'].toString()=='null'?'n/a':json['condition'].toString();
    isFavorite = json['is_favorite'];
    img = json['img'].toString()=='null'?'n/a':json['img'].toString();
    categoryName = json['category_name'].toString()=='null'?'n/a':json['category_name'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['price'] = price;
    data['condition'] = condition;
    data['is_favorite'] = isFavorite;
    data['img'] = img;
    data['category_name'] = categoryName;
    return data;
  }
}

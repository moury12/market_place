
class ProductModel {
  String? sId;
  String? name;
  int? price;
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
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    condition = json['condition'];
    isFavorite = json['is_favorite'];
    img = json['img'];
    categoryName = json['category_name'];
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

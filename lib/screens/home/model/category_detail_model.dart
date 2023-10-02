class CategoryDetailsModel {
  Data? data;
  String? message;
  int? status;

  CategoryDetailsModel({this.data, this.message, this.status});

  CategoryDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }


}

class Data {
  int? id;
  String? name;
  String? slug;
  List<Products>? products;

  Data({this.id, this.name, this.slug, this.products});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

}

class Products {
  int? id;
  String? name;
  String? description;
  int? stock;
  String? price;
  int? bestSeller;
  int? discount;
  num? priceAfterDiscount;
  String? image;

  Products(
      {this.id,
        this.name,
        this.description,
        this.stock,
        this.price,
        this.bestSeller,
        this.discount,
        this.priceAfterDiscount,
        this.image});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    stock = json['stock'];
    price = json['price'];
    bestSeller = json['best_seller'];
    discount = json['discount'];
    priceAfterDiscount = json['price_after_discount'];
    image = json['image'];
  }

}

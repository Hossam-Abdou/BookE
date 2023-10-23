class SingleOrderHistoryModel {
  Data? data;
  String? message;
  int? status;

  SingleOrderHistoryModel({this.data, this.message, this.status});

  SingleOrderHistoryModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

}

class Data {
  int? id;
  String? orderCode;
  String? total;
  String? name;
  String? email;
  String? address;
  String? governorate;
  String? phone;
  String? subTotal;
  String? orderDate;
  String? status;
  int? discount;
  List<OrderProducts>? orderProducts;

  Data(
      {this.id,
        this.orderCode,
        this.total,
        this.name,
        this.email,
        this.address,
        this.governorate,
        this.phone,
        this.subTotal,
        this.orderDate,
        this.status,
        this.discount,
        this.orderProducts});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderCode = json['order_code'];
    total = json['total'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    governorate = json['governorate'];
    phone = json['phone'];
    subTotal = json['sub_total'];
    orderDate = json['order_date'];
    status = json['status'];
    discount = json['discount'];
    if (json['order_products'] != null) {
      orderProducts = <OrderProducts>[];
      json['order_products'].forEach((v) {
        orderProducts!.add(OrderProducts.fromJson(v));
      });
    }
  }

}

class OrderProducts {
  int? orderProductId;
  int? productId;
  String? productName;
  String? productPrice;
  int? productDiscount;
  num? productPriceAfterDiscount;
  int? orderProductQuantity;
  String? productTotal;

  OrderProducts(
      {this.orderProductId,
        this.productId,
        this.productName,
        this.productPrice,
        this.productDiscount,
        this.productPriceAfterDiscount,
        this.orderProductQuantity,
        this.productTotal});

  OrderProducts.fromJson(Map<String, dynamic> json) {
    orderProductId = json['order_product_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    productDiscount = json['product_discount'];
    productPriceAfterDiscount = json['product_price_after_discount'];
    orderProductQuantity = json['order_product_quantity'];
    productTotal = json['product_total'];
  }

}

class OrderHistoryModel {
  Data? data;
  String? message;
  int? status;

  OrderHistoryModel({this.data, this.message, this.status});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }


}

class Data {
  List<Orders>? orders;
  Meta? meta;
  Links? links;

  Data({this.orders, this.meta, this.links});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }

}

class Orders {
  int? id;
  String? orderCode;
  String? orderDate;
  String? status;
  String? total;

  Orders({this.id, this.orderCode, this.orderDate, this.status, this.total});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderCode = json['order_code'];
    orderDate = json['order_date'];
    status = json['status'];
    total = json['total'];
  }


}

class Meta {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;

  Meta({this.total, this.perPage, this.currentPage, this.lastPage});

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
  }


}

class Links {
  String? first;
  String? last;

  Links({this.first, this.last});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
  }


}

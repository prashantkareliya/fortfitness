class DiscountResponse {
  bool? error;
  String? message;
  List<Data>? data;

  DiscountResponse({this.error, this.message, this.data});

  DiscountResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? logo;
  String? description;
  String? address;
  String? discount;
  String? createdAt;
  String? updatedAt;
  bool? isClaimed;

  Data(
      {this.id,
        this.name,
        this.logo,
        this.description,
        this.address,
        this.discount,
        this.createdAt,
        this.updatedAt,
        this.isClaimed});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    description = json['description'];
    address = json['address'];
    discount = json['discount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isClaimed = json['isClaimed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['description'] = this.description;
    data['address'] = this.address;
    data['discount'] = this.discount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['isClaimed'] = this.isClaimed;
    return data;
  }
}

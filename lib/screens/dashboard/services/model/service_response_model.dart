class ServiceResponse {
  bool? error;
  String? message;
  List<Data>? data;

  ServiceResponse({this.error, this.message, this.data});

  ServiceResponse.fromJson(Map<String, dynamic> json) {
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
  String? email;
  int? locationId;
  String? logo;
  String? description;
  String? address;
  String? pdf;
  String? createdAt;
  String? updatedAt;
  bool? isClaimed;
  String? startTime;
  String? endTime;

  Data(
      {this.id,
        this.name,
        this.email,
        this.locationId,
        this.logo,
        this.description,
        this.address,
        this.pdf,
        this.createdAt,
        this.updatedAt,
        this.isClaimed,
        this.startTime,
        this.endTime});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    locationId = json['location_id'];
    logo = json['logo'];
    description = json['description'];
    address = json['address'];
    pdf = json['pdf'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isClaimed = json['isClaimed'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['location_id'] = this.locationId;
    data['logo'] = this.logo;
    data['description'] = this.description;
    data['address'] = this.address;
    data['pdf'] = this.pdf;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['isClaimed'] = this.isClaimed;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}

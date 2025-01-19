class GymLocationResponse {
  bool? error;
  String? message;
  Data? data;

  GymLocationResponse({this.error, this.message, this.data});

  GymLocationResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Locations>? locations;
  int? totalPages;
  int? totalCount;

  Data({this.locations, this.totalPages, this.totalCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(new Locations.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.locations != null) {
      data['locations'] = this.locations!.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    data['totalCount'] = this.totalCount;
    return data;
  }
}

class Locations {
  int? id;
  int? placeId;
  String? name;
  String? description;
  double? latitude;
  double? longitude;
  String? logo;
  int? isPublic;
  int? isBookable;
  String? createdAt;
  String? updatedAt;
  int? activeMembers;
  String? startTime;
  String? endTime;
  bool? isClaimed;

  Locations(
      {this.id,
      this.placeId,
      this.name,
      this.description,
      this.latitude,
      this.longitude,
      this.logo,
      this.isPublic,
      this.isBookable,
      this.createdAt,
      this.updatedAt,
      this.activeMembers,
      this.startTime,
      this.endTime,
      this.isClaimed});

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    placeId = json['place_id'];
    name = json['name'];
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    logo = json['logo'];
    isPublic = json['is_public'];
    isBookable = json['is_bookable'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    activeMembers = json['active_members'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    isClaimed = json['isClaimed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['place_id'] = this.placeId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['logo'] = this.logo;
    data['is_public'] = this.isPublic;
    data['is_bookable'] = this.isBookable;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['active_members'] = this.activeMembers;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['isClaimed'] = this.isClaimed;
    return data;
  }

  bool get isAllowToInGym => (activeMembers ?? 0) <= 50;
}

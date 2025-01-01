class ProfileResponse {
  bool? error;
  String? message;
  Data? data;

  ProfileResponse({this.error, this.message, this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  String? dob;
  String? role;
  int? isActive;
  int? isSuperAdmin;
  int? confirmed;
  int? organizationId;
  int? accessEnabled;
  String? lastAccessedAt;
  int? kisiUserId;
  String? deviceType;
  String? deviceToken;
  String? validToken;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.image,
      this.dob,
      this.role,
      this.isActive,
      this.isSuperAdmin,
      this.confirmed,
      this.organizationId,
      this.accessEnabled,
      this.lastAccessedAt,
      this.kisiUserId,
      this.deviceType,
      this.deviceToken,
      this.validToken,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    image = json['image'];
    dob = json['dob'];
    role = json['role'];
    isActive = json['is_active'];
    isSuperAdmin = json['is_super_admin'];
    confirmed = json['confirmed'];
    organizationId = json['organization_id'];
    accessEnabled = json['access_enabled'];
    lastAccessedAt = json['last_accessed_at'];
    kisiUserId = json['kisi_user_id'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    validToken = json['valid_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['image'] = this.image;
    data['dob'] = this.dob;
    data['role'] = this.role;
    data['is_active'] = this.isActive;
    data['is_super_admin'] = this.isSuperAdmin;
    data['confirmed'] = this.confirmed;
    data['organization_id'] = this.organizationId;
    data['access_enabled'] = this.accessEnabled;
    data['last_accessed_at'] = this.lastAccessedAt;
    data['kisi_user_id'] = this.kisiUserId;
    data['device_type'] = this.deviceType;
    data['device_token'] = this.deviceToken;
    data['valid_token'] = this.validToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

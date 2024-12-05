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
  String? name;
  String? email;
  Null? image;
  String? dob;
  String? role;
  int? isActive;
  int? isSuperAdmin;
  int? confirmed;
  Null? organizationId;
  int? accessEnabled;
  Null? lastAccessedAt;
  Null? kisiUserId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.name,
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
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

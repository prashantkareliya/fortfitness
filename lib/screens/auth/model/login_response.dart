class LoginResponse {
  bool? error;
  String? message;
  Data? data;

  LoginResponse({this.error, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
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
  User? user;
  String? token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? id;
  String? name;
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
  String? createdAt;
  String? updatedAt;

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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
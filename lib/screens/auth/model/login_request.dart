class LoginRequest {
  String? email;
  String? password;
  String? deviceToken;
  String? deviceType;

  LoginRequest({this.email, this.password, this.deviceToken, this.deviceType});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    deviceToken = json['device_token'];
    deviceType = json['device_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['device_token'] = this.deviceToken;
    data['device_type'] = this.deviceType;
    return data;
  }
}

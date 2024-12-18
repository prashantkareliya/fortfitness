class LoginRequest {
  String? email;
  String? password;
  String? deviceToken;

  LoginRequest({this.email, this.password, this.deviceToken});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['device_token'] = this.deviceToken;
    return data;
  }
}

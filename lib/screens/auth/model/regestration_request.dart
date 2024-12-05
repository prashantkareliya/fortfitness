class RegistrationRequest {
  String? name;
  String? email;
  String? password;
  String? dob;

  RegistrationRequest({this.name, this.email, this.password, this.dob});

  RegistrationRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['dob'] = this.dob;
    return data;
  }
}
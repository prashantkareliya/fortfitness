class RegistrationRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? dob;
  String? role;

  RegistrationRequest(
      {this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.dob,
      this.role});

  RegistrationRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    dob = json['dob'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['dob'] = this.dob;
    data['role'] = this.role;
    return data;
  }
}

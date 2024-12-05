class UpdateProfileRequest {
  String? dob;

  UpdateProfileRequest({this.dob});

  UpdateProfileRequest.fromJson(Map<String, dynamic> json) {
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dob'] = this.dob;
    return data;
  }
}

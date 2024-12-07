class UpdateProfileRequest {
  String? dob;
  String? image;

  UpdateProfileRequest({this.dob, this.image});

  UpdateProfileRequest.fromJson(Map<String, dynamic> json) {
    dob = json['dob'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dob'] = this.dob;
    data['image'] = this.image;
    return data;
  }
}

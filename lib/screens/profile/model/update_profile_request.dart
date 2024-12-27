import 'package:http/http.dart' as http;

class UpdateProfileRequest {
  String? dob;
  String? image;
  String? isChangeImage;

  UpdateProfileRequest({this.dob, this.image, this.isChangeImage});

  UpdateProfileRequest.fromJson(Map<String, dynamic> json) {
    dob = json['dob'];
    image = json['image'];
    isChangeImage = json['is_change_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dob'] = this.dob;
    data['image'] = this.image;
    data['is_change_image'] = this.isChangeImage;
    return data;
  }
}

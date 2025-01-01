import 'package:http/http.dart' as http;

class UpdateProfileRequest {
  String? dob;
  String? image;
  String? isChangeImage;
  String? firstName;
  String? lastName;

  UpdateProfileRequest(
      {this.dob,
      this.image,
      this.isChangeImage,
      this.firstName,
      this.lastName});

  UpdateProfileRequest.fromJson(Map<String, dynamic> json) {
    dob = json['dob'];
    image = json['image'];
    isChangeImage = json['is_change_image'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dob'] = this.dob;
    if (image != null && image?.isNotEmpty == true) {
      data['image'] = await http.MultipartFile.fromPath("image", image!);
    }
    data['is_change_image'] = this.isChangeImage;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class GetDiscountClaimResponse {
  bool? error;
  String? message;
  ClaimData? data;

  GetDiscountClaimResponse({this.error, this.message, this.data});

  GetDiscountClaimResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new ClaimData.fromJson(json['data']) : null;
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

class ClaimData {
  bool? locked;

  ClaimData({this.locked});

  ClaimData.fromJson(Map<String, dynamic> json) {
    locked = json['locked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locked'] = this.locked;
    return data;
  }
}

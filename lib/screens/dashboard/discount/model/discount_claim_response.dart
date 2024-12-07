class DiscountClaimResponse {
  bool? error;
  String? message;
  int? data;

  DiscountClaimResponse({this.error, this.message, this.data});

  DiscountClaimResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}

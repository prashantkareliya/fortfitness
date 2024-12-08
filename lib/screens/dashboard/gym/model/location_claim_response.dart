class LocationClaimResponse {
  bool? error;
  String? message;
  int? data;

  LocationClaimResponse({this.error, this.message, this.data});

  LocationClaimResponse.fromJson(Map<String, dynamic> json) {
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

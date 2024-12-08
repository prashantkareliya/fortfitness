class LocationClaimRequest {
  String? locationId;

  LocationClaimRequest({this.locationId});

  LocationClaimRequest.fromJson(Map<String, dynamic> json) {
    locationId = json['location_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location_id'] = this.locationId;
    return data;
  }
}

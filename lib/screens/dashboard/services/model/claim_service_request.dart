class ClaimServiceRequest {
  String? serviceId;
  String? date;
  String? time;

  ClaimServiceRequest({this.serviceId, this.date, this.time});

  ClaimServiceRequest.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}
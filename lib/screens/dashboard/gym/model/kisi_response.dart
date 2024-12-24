class KisiResponse {
  bool? error;
  String? message;
  List<KisiData>? data;

  KisiResponse({this.error, this.message, this.data});

  KisiResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <KisiData>[];
      json['data'].forEach((v) {
        data!.add(new KisiData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class KisiData {
  int? id;
  int? lockId;
  String? createdAt;
  String? updatedAt;
  bool? configured;
  String? description;
  String? firstToArriveRequiredUntil;
  bool? firstToArriveSatisfied;
  String? floorId;
  bool? geofenceRestrictionEnabled;
  int? geofenceRestrictionRadius;
  int? groupsCount;
  String? integrationId;
  String? latitude;
  String? lockedDownSince;
  bool? lockedDown;
  String? longitude;
  String? name;
  bool? onScheduledUnlock;
  bool? online;
  bool? open;
  String? orderId;
  int? placeId;
  bool? readerRestrictionEnabled;
  String? timeRestrictionEnabled;
  String? timeRestrictionTimeZone;
  bool? unlocked;
  String? unlockedUntil;
  Place? place;

  KisiData(
      {this.id,
        this.lockId,
        this.createdAt,
        this.updatedAt,
        this.configured,
        this.description,
        this.firstToArriveRequiredUntil,
        this.firstToArriveSatisfied,
        this.floorId,
        this.geofenceRestrictionEnabled,
        this.geofenceRestrictionRadius,
        this.groupsCount,
        this.integrationId,
        this.latitude,
        this.lockedDownSince,
        this.lockedDown,
        this.longitude,
        this.name,
        this.onScheduledUnlock,
        this.online,
        this.open,
        this.orderId,
        this.placeId,
        this.readerRestrictionEnabled,
        this.timeRestrictionEnabled,
        this.timeRestrictionTimeZone,
        this.unlocked,
        this.unlockedUntil,
        this.place});

  KisiData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lockId = json['lock_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    configured = json['configured'];
    description = json['description'];
    firstToArriveRequiredUntil = json['first_to_arrive_required_until'];
    firstToArriveSatisfied = json['first_to_arrive_satisfied'];
    floorId = json['floor_id'];
    geofenceRestrictionEnabled = json['geofence_restriction_enabled'];
    geofenceRestrictionRadius = json['geofence_restriction_radius'];
    groupsCount = json['groups_count'];
    integrationId = json['integration_id'];
    latitude = json['latitude'];
    lockedDownSince = json['locked_down_since'];
    lockedDown = json['locked_down'];
    longitude = json['longitude'];
    name = json['name'];
    onScheduledUnlock = json['on_scheduled_unlock'];
    online = json['online'];
    open = json['open'];
    orderId = json['order_id'];
    placeId = json['place_id'];
    readerRestrictionEnabled = json['reader_restriction_enabled'];
    timeRestrictionEnabled = json['time_restriction_enabled'];
    timeRestrictionTimeZone = json['time_restriction_time_zone'];
    unlocked = json['unlocked'];
    unlockedUntil = json['unlocked_until'];
    place = json['place'] != null ? new Place.fromJson(json['place']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lock_id'] = this.lockId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['configured'] = this.configured;
    data['description'] = this.description;
    data['first_to_arrive_required_until'] = this.firstToArriveRequiredUntil;
    data['first_to_arrive_satisfied'] = this.firstToArriveSatisfied;
    data['floor_id'] = this.floorId;
    data['geofence_restriction_enabled'] = this.geofenceRestrictionEnabled;
    data['geofence_restriction_radius'] = this.geofenceRestrictionRadius;
    data['groups_count'] = this.groupsCount;
    data['integration_id'] = this.integrationId;
    data['latitude'] = this.latitude;
    data['locked_down_since'] = this.lockedDownSince;
    data['locked_down'] = this.lockedDown;
    data['longitude'] = this.longitude;
    data['name'] = this.name;
    data['on_scheduled_unlock'] = this.onScheduledUnlock;
    data['online'] = this.online;
    data['open'] = this.open;
    data['order_id'] = this.orderId;
    data['place_id'] = this.placeId;
    data['reader_restriction_enabled'] = this.readerRestrictionEnabled;
    data['time_restriction_enabled'] = this.timeRestrictionEnabled;
    data['time_restriction_time_zone'] = this.timeRestrictionTimeZone;
    data['unlocked'] = this.unlocked;
    data['unlocked_until'] = this.unlockedUntil;
    if (this.place != null) {
      data['place'] = this.place!.toJson();
    }
    return data;
  }
}

class Place {
  int? id;
  String? name;
  double? latitude;
  double? longitude;

  Place({this.id, this.name, this.latitude, this.longitude});

  Place.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

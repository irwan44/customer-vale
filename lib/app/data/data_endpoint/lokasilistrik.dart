class LokasiListrik {
  bool? status;
  String? message;
  List<DatachargingStation>? datachargingStation;

  LokasiListrik({this.status, this.message, this.datachargingStation});

  LokasiListrik.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['datachargingStation'] != null) {
      datachargingStation = <DatachargingStation>[];
      json['datachargingStation'].forEach((v) {
        datachargingStation!.add(new DatachargingStation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.datachargingStation != null) {
      data['datachargingStation'] =
          this.datachargingStation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DatachargingStation {
  String? name;
  Geometry? geometry;
  String? vicinity;
  String? city;
  String? power;

  DatachargingStation(
      {this.name, this.geometry, this.vicinity, this.city, this.power});

  DatachargingStation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    vicinity = json['vicinity'];
    city = json['city'];
    power = json['power'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    data['vicinity'] = this.vicinity;
    data['city'] = this.city;
    data['power'] = this.power;
    return data;
  }
}

class Geometry {
  Location? location;

  Geometry({this.location});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}

class Location {
  int? id;
  String? lat;
  String? lng;

  Location({this.id, this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
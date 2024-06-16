class Lokasi {
  bool? status;
  String? message;
  List<DataLokasi>? data;

  Lokasi({this.status, this.message, this.data});

  Lokasi.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataLokasi>[];
      json['data'].forEach((v) {
        data!.add(new DataLokasi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataLokasi {
  String? name;
  Geometry? geometry;
  String? vicinity;
  String? wa;

  DataLokasi({this.name, this.geometry, this.vicinity, this.wa});

  DataLokasi.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    vicinity = json['vicinity'];
    wa = json['wa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    data['vicinity'] = this.vicinity;
    data['wa'] = this.wa;
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

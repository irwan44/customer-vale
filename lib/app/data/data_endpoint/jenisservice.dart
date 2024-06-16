class JenisServiceResponse {
  bool? status;
  String? message;
  List<JenisServices>? dataservice;

  JenisServiceResponse({this.status, this.message, this.dataservice});

  JenisServiceResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      dataservice = <JenisServices>[];
      json['data'].forEach((v) {
        dataservice!.add(JenisServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.dataservice != null) {
      data['data'] = this.dataservice!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JenisServices {
  int? id;
  String? namaJenissvc;
  int? deleted;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  JenisServices({
    this.id,
    this.namaJenissvc,
    this.deleted,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  JenisServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaJenissvc = json['nama_jenissvc'];
    deleted = json['deleted'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama_jenissvc'] = namaJenissvc;
    data['deleted'] = deleted;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

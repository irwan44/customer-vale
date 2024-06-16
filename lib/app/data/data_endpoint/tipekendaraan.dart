class TipeKendaraan {
  bool? status;
  String? message;
  List<DataTipe>? data;

  TipeKendaraan({this.status, this.message, this.data});

  TipeKendaraan.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataTipe>[];
      json['data'].forEach((v) {
        data!.add(new DataTipe.fromJson(v));
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

class DataTipe {
  int? id;
  int? idMerk;
  String? namaTipe;
  int? deleted;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  Merk? merk;

  DataTipe(
      {this.id,
        this.idMerk,
        this.namaTipe,
        this.deleted,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.merk});

  DataTipe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMerk = json['id_merk'];
    namaTipe = json['nama_tipe'];
    deleted = json['deleted'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    merk = json['merk'] != null ? new Merk.fromJson(json['merk']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_merk'] = this.idMerk;
    data['nama_tipe'] = this.namaTipe;
    data['deleted'] = this.deleted;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.merk != null) {
      data['merk'] = this.merk!.toJson();
    }
    return data;
  }
}

class Merk {
  int? id;
  String? namaMerk;
  int? deleted;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  Merk(
      {this.id,
        this.namaMerk,
        this.deleted,
        this.createdBy,
        this.createdAt,
        this.updatedAt});

  Merk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaMerk = json['nama_merk'];
    deleted = json['deleted'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_merk'] = this.namaMerk;
    data['deleted'] = this.deleted;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
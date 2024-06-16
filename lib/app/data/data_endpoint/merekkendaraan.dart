class MerekKendaraan {
  bool? status;
  String? message;
  List<Data>? data;

  MerekKendaraan({this.status, this.message, this.data});

  MerekKendaraan.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? namaMerk;
  String? namaTipe;
  String? idMerk;
  int? deleted;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.namaMerk,
    this.namaTipe,
    this.idMerk,
    this.deleted,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaMerk = json['nama_merk'];
    namaTipe = json['nama_tipe'];
    idMerk = json['id_merk'];
    deleted = json['deleted'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['nama_merk'] = this.namaMerk;
    data['nama_tipe'] = this.namaTipe;
    data['deleted'] = this.deleted;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}



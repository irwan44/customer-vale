class CreateKendaraan {
  bool? status;
  String? message;
  Data? data;

  CreateKendaraan({this.status, this.message, this.data});

  CreateKendaraan.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? noPolisi;
  int? idMerk;
  int? idTipe;
  String? warna;
  String? tahun;
  int? idCustomer;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.noPolisi,
        this.idMerk,
        this.idTipe,
        this.warna,
        this.tahun,
        this.idCustomer,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    noPolisi = json['no_polisi'];
    idMerk = json['id_merk'];
    idTipe = json['id_tipe'];
    warna = json['warna'];
    tahun = json['tahun'];
    idCustomer = json['id_customer'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_polisi'] = this.noPolisi;
    data['id_merk'] = this.idMerk;
    data['id_tipe'] = this.idTipe;
    data['warna'] = this.warna;
    data['tahun'] = this.tahun;
    data['id_customer'] = this.idCustomer;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
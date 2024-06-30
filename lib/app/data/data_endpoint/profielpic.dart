class ProfilePIC {
  bool? status;
  String? message;
  DataPic? dataPic;

  ProfilePIC({this.status, this.message, this.dataPic});

  ProfilePIC.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    dataPic =
    json['DataPic'] != null ? new DataPic.fromJson(json['DataPic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.dataPic != null) {
      data['DataPic'] = this.dataPic!.toJson();
    }
    return data;
  }
}

class DataPic {
  int? id;
  String? nama;
  String? email;
  String? alamat;
  String? mandor;
  String? noTelepon;
  String? createdAt;
  String? updatedAt;
  List<Kendaraan>? kendaraan;

  DataPic(
      {this.id,
        this.nama,
        this.email,
        this.alamat,
        this.mandor,
        this.noTelepon,
        this.createdAt,
        this.updatedAt,
        this.kendaraan});

  DataPic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    email = json['email'];
    alamat = json['alamat'];
    mandor = json['mandor'];
    noTelepon = json['no_telepon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['kendaraan'] != null) {
      kendaraan = <Kendaraan>[];
      json['kendaraan'].forEach((v) {
        kendaraan!.add(new Kendaraan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['email'] = this.email;
    data['alamat'] = this.alamat;
    data['mandor'] = this.mandor;
    data['no_telepon'] = this.noTelepon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.kendaraan != null) {
      data['kendaraan'] = this.kendaraan!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Kendaraan {
  String? emailPic;
  String? namaMerk;
  String? namaTipe;
  String? noPolisi;

  Kendaraan({this.emailPic, this.namaMerk, this.namaTipe, this.noPolisi});

  Kendaraan.fromJson(Map<String, dynamic> json) {
    emailPic = json['email_pic'];
    namaMerk = json['nama_merk'];
    namaTipe = json['nama_tipe'];
    noPolisi = json['no_polisi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email_pic'] = this.emailPic;
    data['nama_merk'] = this.namaMerk;
    data['nama_tipe'] = this.namaTipe;
    data['no_polisi'] = this.noPolisi;
    return data;
  }
}
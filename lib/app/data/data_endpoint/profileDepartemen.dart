class ProfileDepartemen {
  bool? status;
  String? message;
  DataDepartemen? dataDepartemen;

  ProfileDepartemen({this.status, this.message, this.dataDepartemen});

  ProfileDepartemen.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    dataDepartemen = json['DataDepartemen'] != null
        ? new DataDepartemen.fromJson(json['DataDepartemen'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.dataDepartemen != null) {
      data['DataDepartemen'] = this.dataDepartemen!.toJson();
    }
    return data;
  }
}

class DataDepartemen {
  int? id;
  String? nama;
  String? email;
  String? alamat;
  String? mandor;
  String? noTelepon;
  String? createdAt;
  String? updatedAt;
  List<Kendaraan>? kendaraan;

  DataDepartemen(
      {this.id,
        this.nama,
        this.email,
        this.alamat,
        this.mandor,
        this.noTelepon,
        this.createdAt,
        this.updatedAt,
        this.kendaraan});

  DataDepartemen.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? warna;
  String? tahun;
  String? noPolisi;
  String? vinNumber;
  String? namaMerk;
  String? namaTipe;

  Kendaraan(
      {this.id,
        this.warna,
        this.tahun,
        this.noPolisi,
        this.vinNumber,
        this.namaMerk,
        this.namaTipe});

  Kendaraan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    warna = json['warna'];
    tahun = json['tahun'];
    noPolisi = json['no_polisi'];
    vinNumber = json['vin_number'];
    namaMerk = json['nama_merk'];
    namaTipe = json['nama_tipe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['warna'] = this.warna;
    data['tahun'] = this.tahun;
    data['no_polisi'] = this.noPolisi;
    data['vin_number'] = this.vinNumber;
    data['nama_merk'] = this.namaMerk;
    data['nama_tipe'] = this.namaTipe;
    return data;
  }
}
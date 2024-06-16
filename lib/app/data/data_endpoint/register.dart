class Register {
  bool? status;
  String? message;
  Data? data;

  Register({this.status, this.message, this.data});

  Register.fromJson(Map<String, dynamic> json) {
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
  Customer? customer;
  Kendaraan? kendaraan;

  Data({this.customer, this.kendaraan});

  Data.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    kendaraan = json['kendaraan'] != null
        ? new Kendaraan.fromJson(json['kendaraan'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.kendaraan != null) {
      data['kendaraan'] = this.kendaraan!.toJson();
    }
    return data;
  }
}

class Customer {
  String? kode;
  String? nama;
  String? hp;
  String? email;
  String? createdBy;
  String? alamat;
  String? password;
  String? updatedAt;
  String? createdAt;
  int? id;

  Customer(
      {this.kode,
        this.nama,
        this.hp,
        this.email,
        this.createdBy,
        this.alamat,
        this.password,
        this.updatedAt,
        this.createdAt,
        this.id});

  Customer.fromJson(Map<String, dynamic> json) {
    kode = json['kode'];
    nama = json['nama'];
    hp = json['hp'];
    email = json['email'];
    createdBy = json['created_by'];
    alamat = json['alamat'];
    password = json['password'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kode'] = this.kode;
    data['nama'] = this.nama;
    data['hp'] = this.hp;
    data['email'] = this.email;
    data['created_by'] = this.createdBy;
    data['alamat'] = this.alamat;
    data['password'] = this.password;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

class Kendaraan {
  String? kode;
  String? kodePelanggan;
  String? noPolisi;
  String? idMerk;
  String? idTipe;
  String? transmisi;
  String? kategoriKendaraan;
  String? warna;
  String? tahun;
  String? createdBy;
  String? updatedAt;
  String? createdAt;
  int? id;
  Merks? merks;
  List<Tipes>? tipes;

  Kendaraan(
      {this.kode,
        this.kodePelanggan,
        this.noPolisi,
        this.idMerk,
        this.idTipe,
        this.transmisi,
        this.kategoriKendaraan,
        this.warna,
        this.tahun,
        this.createdBy,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.merks,
        this.tipes});

  Kendaraan.fromJson(Map<String, dynamic> json) {
    kode = json['kode'];
    kodePelanggan = json['kode_pelanggan'];
    noPolisi = json['no_polisi'];
    idMerk = json['id_merk'];
    idTipe = json['id_tipe'];
    transmisi = json['transmisi'];
    kategoriKendaraan = json['kategori_kendaraan'];
    warna = json['warna'];
    tahun = json['tahun'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    merks = json['merks'] != null ? new Merks.fromJson(json['merks']) : null;
    if (json['tipes'] != null) {
      tipes = <Tipes>[];
      json['tipes'].forEach((v) {
        tipes!.add(new Tipes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kode'] = this.kode;
    data['kode_pelanggan'] = this.kodePelanggan;
    data['no_polisi'] = this.noPolisi;
    data['id_merk'] = this.idMerk;
    data['id_tipe'] = this.idTipe;
    data['transmisi'] = this.transmisi;
    data['kategori_kendaraan'] = this.kategoriKendaraan;
    data['warna'] = this.warna;
    data['tahun'] = this.tahun;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    if (this.merks != null) {
      data['merks'] = this.merks!.toJson();
    }
    if (this.tipes != null) {
      data['tipes'] = this.tipes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Merks {
  int? id;
  String? namaMerk;

  Merks({this.id, this.namaMerk});

  Merks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaMerk = json['nama_merk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_merk'] = this.namaMerk;
    return data;
  }
}

class Tipes {
  int? id;
  String? namaTipe;

  Tipes({this.id, this.namaTipe});

  Tipes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaTipe = json['nama_tipe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_tipe'] = this.namaTipe;
    return data;
  }
}
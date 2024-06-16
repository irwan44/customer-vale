class Login {
  bool? status;
  String? message;
  String? token;
  Data? data;

  Login({this.status, this.message, this.token, this.data});

  Login.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? nama;
  String? hp;
  String? email;
  String? alamat;
  int? deleted;
  String? createdAt;
  String? updatedAt;
  List<Kendaraan>? kendaraan;

  Data({
    this.id,
    this.nama,
    this.hp,
    this.email,
    this.alamat,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.kendaraan,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    hp = json['hp'];
    email = json['email'];
    alamat = json['alamat'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['kendaraan'] != null) {
      kendaraan = <Kendaraan>[];
      json['kendaraan'].forEach((v) {
        kendaraan!.add(Kendaraan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['hp'] = this.hp;
    data['email'] = this.email;
    data['alamat'] = this.alamat;
    data['deleted'] = this.deleted;
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
  String? kode;
  String? kodePelanggan;
  String? noPolisi;
  int? idMerk;
  int? idTipe;
  String? tahun;
  String? warna;
  String? transmisi;
  String? noRangka;
  String? noMesin;
  String? modelKaroseri;
  String? drivingMode;
  String? power;
  String? kategoriKendaraan;
  String? jenisKontrak;
  int? deleted;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  String? idCustomer;
  Merks? merks;
  List<Tipes>? tipes;

  Kendaraan({
    this.id,
    this.kode,
    this.kodePelanggan,
    this.noPolisi,
    this.idMerk,
    this.idTipe,
    this.tahun,
    this.warna,
    this.transmisi,
    this.noRangka,
    this.noMesin,
    this.modelKaroseri,
    this.drivingMode,
    this.power,
    this.kategoriKendaraan,
    this.jenisKontrak,
    this.deleted,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.idCustomer,
    this.merks,
    this.tipes,
  });

  Kendaraan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kode = json['kode'];
    kodePelanggan = json['kode_pelanggan'];
    noPolisi = json['no_polisi'];
    idMerk = json['id_merk'];
    idTipe = json['id_tipe'];
    tahun = json['tahun'];
    warna = json['warna'];
    transmisi = json['transmisi'];
    noRangka = json['no_rangka'];
    noMesin = json['no_mesin'];
    modelKaroseri = json['model_karoseri'];
    drivingMode = json['driving_mode'];
    power = json['power'];
    kategoriKendaraan = json['kategori_kendaraan'];
    jenisKontrak = json['jenis_kontrak'];
    deleted = json['deleted'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    idCustomer = json['id_customer'];
    merks = json['merks'] != null ? Merks.fromJson(json['merks']) : null;
    if (json['tipes'] != null) {
      tipes = <Tipes>[];
      json['tipes'].forEach((v) {
        tipes!.add(Tipes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['kode'] = this.kode;
    data['kode_pelanggan'] = this.kodePelanggan;
    data['no_polisi'] = this.noPolisi;
    data['id_merk'] = this.idMerk;
    data['id_tipe'] = this.idTipe;
    data['tahun'] = this.tahun;
    data['warna'] = this.warna;
    data['transmisi'] = this.transmisi;
    data['no_rangka'] = this.noRangka;
    data['no_mesin'] = this.noMesin;
    data['model_karoseri'] = this.modelKaroseri;
    data['driving_mode'] = this.drivingMode;
    data['power'] = this.power;
    data['kategori_kendaraan'] = this.kategoriKendaraan;
    data['jenis_kontrak'] = this.jenisKontrak;
    data['deleted'] = this.deleted;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['id_customer'] = this.idCustomer;
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['nama_tipe'] = this.namaTipe;
    return data;
  }
}

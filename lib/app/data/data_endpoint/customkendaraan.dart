class CustomerKendaraan {
  bool? status;
  String? message;
  List<DataKendaraan>? datakendaraan;

  CustomerKendaraan({this.status, this.message, this.datakendaraan});

  CustomerKendaraan.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      datakendaraan = <DataKendaraan>[];
      json['data'].forEach((v) {
        datakendaraan!.add(new DataKendaraan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.datakendaraan != null) {
      data['data'] = this.datakendaraan!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataKendaraan {
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
  String? picIdPelanggan;
  int? idCustomer;
  MerksKendaraan? merks;
  List<TipeKendaraanCustommer>? tipes;

  DataKendaraan(
      {this.id,
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
        this.picIdPelanggan,
        this.idCustomer,
        this.merks,
        this.tipes});

  DataKendaraan.fromJson(Map<String, dynamic> json) {
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
    picIdPelanggan = json['pic_id_pelanggan'];
    idCustomer = json['id_customer'];
    merks = json['merks'] != null ? new MerksKendaraan.fromJson(json['merks']) : null;
    if (json['tipes'] != null) {
      tipes = <TipeKendaraanCustommer>[];
      json['tipes'].forEach((v) {
        tipes!.add(new TipeKendaraanCustommer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['pic_id_pelanggan'] = this.picIdPelanggan;
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

class MerksKendaraan {
  int? id;
  String? namaMerk;

  MerksKendaraan({this.id, this.namaMerk});

  MerksKendaraan.fromJson(Map<String, dynamic> json) {
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

class TipeKendaraanCustommer {
  int? id;
  String? namaTipe;

  TipeKendaraanCustommer({this.id, this.namaTipe});

  TipeKendaraanCustommer.fromJson(Map<String, dynamic> json) {
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
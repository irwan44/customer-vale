class HistoryBooking {
  bool? status;
  String? message;
  List<DataHis>? datahistory;

  HistoryBooking({this.status, this.message, this.datahistory});

  HistoryBooking.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      datahistory = <DataHis>[];
      json['data'].forEach((v) {
        datahistory!.add(new DataHis.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.datahistory != null) {
      data['data'] = this.datahistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataHis {
  int? id;
  String? namaPelanggan;
  String? namaCabang;
  String? alamat;
  String? noPolisi;
  String? namaStatus;
  String? namaJenissvc;
  List<Jasa>? jasa;
  List<Part>? part;
  String? message;

  DataHis(
      {this.id,
        this.namaPelanggan,
        this.namaCabang,
        this.alamat,
        this.noPolisi,
        this.namaStatus,
        this.namaJenissvc,
        this.jasa,
        this.part,
        this.message});

  DataHis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaPelanggan = json['nama_pelanggan'];
    namaCabang = json['nama_cabang'];
    alamat = json['alamat'];
    noPolisi = json['no_polisi'];
    namaStatus = json['nama_status'];
    namaJenissvc = json['nama_jenissvc'];
    if (json['jasa'] != null) {
      jasa = <Jasa>[];
      json['jasa'].forEach((v) {
        jasa!.add(new Jasa.fromJson(v));
      });
    }
    if (json['part'] != null) {
      part = <Part>[];
      json['part'].forEach((v) {
        part!.add(new Part.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_pelanggan'] = this.namaPelanggan;
    data['nama_cabang'] = this.namaCabang;
    data['alamat'] = this.alamat;
    data['no_polisi'] = this.noPolisi;
    data['nama_status'] = this.namaStatus;
    data['nama_jenissvc'] = this.namaJenissvc;
    if (this.jasa != null) {
      data['jasa'] = this.jasa!.map((v) => v.toJson()).toList();
    }
    if (this.part != null) {
      data['part'] = this.part!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Jasa {
  String? tgl;
  String? kodeJasa;
  String? namaJasa;
  int? qtyJasa;
  int? harga;

  Jasa({this.tgl, this.kodeJasa, this.namaJasa, this.qtyJasa, this.harga});

  Jasa.fromJson(Map<String, dynamic> json) {
    tgl = json['tgl'];
    kodeJasa = json['kode_jasa'];
    namaJasa = json['nama_jasa'];
    qtyJasa = json['qty_jasa'];
    harga = json['harga'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tgl'] = this.tgl;
    data['kode_jasa'] = this.kodeJasa;
    data['nama_jasa'] = this.namaJasa;
    data['qty_jasa'] = this.qtyJasa;
    data['harga'] = this.harga;
    return data;
  }
}

class Part {
  String? tgl;
  String? kodeSparepart;
  String? namaSparepart;
  int? qtySparepart;
  int? harga;

  Part(
      {this.tgl,
        this.kodeSparepart,
        this.namaSparepart,
        this.qtySparepart,
        this.harga});

  Part.fromJson(Map<String, dynamic> json) {
    tgl = json['tgl'];
    kodeSparepart = json['kode_sparepart'];
    namaSparepart = json['nama_sparepart'];
    qtySparepart = json['qty_sparepart'];
    harga = json['harga'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tgl'] = this.tgl;
    data['kode_sparepart'] = this.kodeSparepart;
    data['nama_sparepart'] = this.namaSparepart;
    data['qty_sparepart'] = this.qtySparepart;
    data['harga'] = this.harga;
    return data;
  }
}
class PicLogin {
  bool? status;
  String? message;
  String? token;
  DataPic? dataPic;

  PicLogin({this.status, this.message, this.token, this.dataPic});

  PicLogin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    dataPic =
    json['DataPic'] != null ? new DataPic.fromJson(json['DataPic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
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
  Null? alamat;
  String? mandor;
  Null? noTelepon;
  String? createdAt;
  String? updatedAt;

  DataPic(
      {this.id,
        this.nama,
        this.email,
        this.alamat,
        this.mandor,
        this.noTelepon,
        this.createdAt,
        this.updatedAt});

  DataPic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    email = json['email'];
    alamat = json['alamat'];
    mandor = json['mandor'];
    noTelepon = json['no_telepon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}
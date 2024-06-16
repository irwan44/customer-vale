class Profile {
  bool? status;
  String? message;
  Data? data;

  Profile({this.status, this.message, this.data});

  Profile.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? nama;
  String? hp;
  String? email;
  String? alamat;
  String? gambar;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.nama,
        this.hp,
        this.email,
        this.alamat,
        this.gambar,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    hp = json['hp'];
    email = json['email'];
    alamat = json['alamat'];
    gambar = json['gambar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['hp'] = this.hp;
    data['email'] = this.email;
    data['alamat'] = this.alamat;
    data['gambar'] = this.gambar;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
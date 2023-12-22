class UsahaModel {
  final int? usaha_id;
  final int? usaha_idpengguna;
  final int? usaha_idkategori;
  final String? usaha_nama;
  final String? usaha_produk;
  final String? usaha_kontak;
  final String? usaha_deskripsi;
  final String? usaha_gambar;
  final double? usaha_latitude;
  final double? usaha_longitude;
  final String? usaha_alamat;
  final String? usaha_kota;
  final String? usaha_provinsi;
  final String? usaha_active;
  final String? updated_at;
  final String? created_at;

  UsahaModel({
    this.usaha_id,
    this.usaha_idpengguna,
    this.usaha_idkategori,
    this.usaha_nama,
    this.usaha_produk,
    this.usaha_kontak,
    this.usaha_deskripsi,
    this.usaha_gambar,
    this.usaha_latitude,
    this.usaha_longitude,
    this.usaha_alamat,
    this.usaha_kota,
    this.usaha_provinsi,
    this.usaha_active,
    this.updated_at,
    this.created_at,
  });

  factory UsahaModel.fromJson(Map<String, dynamic> json) {
    double? latitude = null;
    if (json['usaha_latitude'] != null) {
      latitude = double.parse(json['usaha_latitude'].toString());
    }
    double? longitude = null;
    if (json['usaha_longitude'] != null) {
      longitude = double.parse(json['usaha_longitude'].toString());
    }
    return UsahaModel(
        usaha_id: json['usaha_id'],
        usaha_idpengguna: json['usaha_idpengguna'],
        usaha_idkategori: json['usaha_idkategori'],
        usaha_nama: json['usaha_nama'],
        usaha_produk: json['usaha_produk'],
        usaha_kontak: json['usaha_kontak'],
        usaha_deskripsi: json['usaha_deskripsi'],
        usaha_gambar: json['usaha_gambar'],
        usaha_latitude: latitude,
        usaha_longitude: longitude,
        usaha_alamat: json['usaha_alamat'],
        usaha_kota: json['usaha_kota'],
        usaha_provinsi: json['usaha_provinsi'],
        usaha_active: json['usaha_active'],
        updated_at: json['updated_at'],
        created_at: json['created_at']);
  }
}

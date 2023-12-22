class UserModel {
  final int? user_id;
  final int? user_idkategori;
  final String? user_nama;
  final String? user_email;
  final String? user_telepon;
  final String? user_gender;
  final String? user_alamat;
  final String? user_foto;
  final int? user_active;
  final String? created_at;
  final String? updated_at;

  const UserModel({
    this.user_id,
    this.user_nama,
    this.user_idkategori,
    this.user_email,
    this.user_telepon,
    this.user_gender,
    this.user_alamat,
    this.user_foto,
    this.user_active,
    this.created_at,
    this.updated_at,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        user_id: json['user_id'],
        user_nama: json['user_nama'],
        user_idkategori: json['user_idkategori'],
        user_email: json['user_email'],
        user_telepon: json['user_telepon'],
        user_gender: json['user_gender'],
        user_alamat: json['user_alamat'],
        user_foto: json['user_foto'],
        user_active: json['user_active'],
        created_at: json['created_at'],
        updated_at: json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'user_nama': user_nama,
      'user_idkategori': user_idkategori,
      'user_email': user_email,
      'user_telepon': user_telepon,
      'user_gender': user_gender,
      'user_alamat': user_alamat,
      'user_foto': user_foto,
      'user_active': user_active,
      'created_at': created_at,
      'updated_at': updated_at
    };
  }
}

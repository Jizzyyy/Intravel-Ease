class WisataImageModel {
  final int? gambar_wisata_id;
  final int? gambar_wisata_idwisata;
  final String? gambar_wisata_gambar;
  WisataImageModel(
      {this.gambar_wisata_id,
      this.gambar_wisata_idwisata,
      this.gambar_wisata_gambar});
  factory WisataImageModel.fromJson(Map<String, dynamic> json) {
    return WisataImageModel(
      gambar_wisata_id: json['gambar_wisata_id'],
      gambar_wisata_idwisata: json['gambar_wisata_idwisata'],
      gambar_wisata_gambar: json['gambar_wisata_gambar'],
    );
  }
}

class Product {
  final String nama;
  final String kategori;

  Product({required this.nama, required this.kategori});
}

final List<Product> produklist = [
  Product(nama: 'Pantai Prigi', kategori: '#rekomendasi wisata'),
  Product(nama: 'Pantai Parangtritis', kategori: '#rekomendasi wisata'),
  Product(nama: 'Gudeg Jogja', kategori: '#rekomendasi kuliner'),
  Product(nama: 'Air Terjun Singokromo', kategori: '#wisata terdekat'),
  Product(nama: 'Rawon Jawir', kategori: '#kuliner terdekat'),
];

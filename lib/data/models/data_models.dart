
class Product {
  int? id;
  String? namaProduk;
  int? harga;
  int? stock;
  String? gambar;

  Product({
    this.id,
    this.namaProduk,
    this.harga,
    this.stock,
    this.gambar,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaProduk = json['namaProduk'];
    harga = json['harga'];
    stock = json['stock'];
    gambar = json['gambar'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'namaProduk': namaProduk,
      'harga': harga,
      'stock': stock,
      'gambar': gambar,
    };
  }
}
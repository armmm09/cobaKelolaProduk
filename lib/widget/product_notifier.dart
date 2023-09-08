import 'package:cobaKelolaProduk/data/models/data_models.dart';


import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

List<Product> daftarProducts = [
  Product(
    id: 1,
    namaProduk: 'Apple',
    harga: 55000,
    stock: 33,
    gambar: 'https://vignette.wikia.nocookie.net/fruits-information/images/2/2b/Apple.jpg/revision/latest?cb=20180802112257',
  ),
  Product(
    id: 2,
    namaProduk: 'Orange',
    harga: 35000,
    stock: 20,
    gambar: 'https://vignette.wikia.nocookie.net/fruits-information/images/2/2b/Apple.jpg/revision/latest?cb=20180802112257',
  ),
  Product(
    id: 3,
    namaProduk: 'Banana',
    harga: 25000,
    stock: 50,
    gambar: 'https://vignette.wikia.nocookie.net/fruits-information/images/2/2b/Apple.jpg/revision/latest?cb=20180802112257',
  ),
];


class ProductListNotifier extends StateNotifier<Product> {
  ProductListNotifier() : super(Product()){
    getProduct();
  }

  List<Product> products = []; // List of Product objects
  List<Product> searchResults = [];

  bool isLoading = false;

  

  void create(Product data) {
    try {
      products.add(data);
      
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void search(String query) {
    searchResults = products.where((product) {
      return (product.namaProduk ?? '').toLowerCase().contains(query.toLowerCase()) ||
          product.id.toString() == query;
    }).toList();
    
  }

  Future<void> getProduct() async {
    try {
      isLoading = true;
      

     await Future.delayed(1.s);


      // Convert daftarProducts to Product objects using fromJson()
      products = daftarProducts.map((e) => Product.fromJson(e.toJson())).toList();

      isLoading = false;
      
    } catch (e,s) {
      Errors.check(e,s);
      // Handle errors
    }
  }

  void update(int id, Product value) {
    try {
      final index = products.indexWhere((e) => e.id == id);
      if (index > -1) {
        products[index] = value;
        
      }
    } catch (e,s) {
      Errors.check(e,s);
      // Handle errors
    }
  }

  void deleteProduct(int productId) {
    products.removeWhere((product) => product.id == productId);
    
  }
}


final productProvider =
    StateNotifierProvider<ProductListNotifier, Product>(
        (ref) => ProductListNotifier());

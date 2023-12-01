import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product_model.dart';
import 'apiservice.dart';

final productControllerProvider = Provider((ref){
  final productRepo = ref.watch(productRepoProvider);
  return ProductController(productRepo: productRepo);
});

class ProductController {
  final ProductRepo _productRepo;

  ProductController({required ProductRepo productRepo}):_productRepo = productRepo;

  Future<List<Product>> getProducts() async {
    final response = await _productRepo.getProducts();
    final data = jsonDecode(response.body);
    List<Product> products = [];
    final productsJson = data['products'];

    for(dynamic productJson in productsJson){
      products.add(Product.fromJson(productJson));
    }
    return products;
  }
}
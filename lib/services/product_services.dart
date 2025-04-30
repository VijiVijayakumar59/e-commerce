import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shopify/core/endpoints.dart';
import 'package:shopify/models/product_model.dart';

class ProductServices {
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(Endpoints.productUrl));
      log(response.toString());
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final List<Product> data = jsonList.map((json) => Product.fromJson(json)).toList();
        return data;
      } else {
        throw Exception('Failed to load products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}

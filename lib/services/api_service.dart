import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kaykommerce/models/brand.dart';
import 'package:kaykommerce/models/product.dart';

class ApiService {
  static final endpoint = 'asos2.p.rapidapi.com';
  static const headers = {
    'x-rapidapi-key': '715ec1571dmsh4f92f9a260d0a7bp188862jsn58ca9436f2b5',
    'x-rapidapi-host': 'asos2.p.rapidapi.com'
  };

  var client = http.Client();

  Future<List<Product>> getProductsList(String categoryId) async {
    var params = {
      'store': 'US',
      'offset': '0',
      'categoryId': categoryId,
      'limit': '20',
      'country': 'US',
      'sort': 'freshness',
      'currency': 'USD',
      'lang': 'en-US',
    };

    var products = <Product>[];
    var uri = Uri.https(endpoint, '/products/v2/list', params);

    try {
      var response = await client.get(uri, headers: headers);
      if (response.statusCode == 200) {
        var parsed = json.decode(response.body);
        var productsList = parsed['products'] as List<dynamic>;
        for (var product in productsList) {
          products.add(Product.fromJson(product));
        }
      } else {
        print('Http No success!');
      }
    } catch (error) {
      throw error.toString();
    }
    return products;
  }

  Future<List<BrandCategory>> getBrands() async {
    var brands = <BrandCategory>[];
    var uri = Uri.https(endpoint, '/categories/list');

    try {
      var response = await client.get(uri, headers: headers);
      if (response.statusCode == 200) {
        var parsed = json.decode(response.body);
        var brandsList = parsed['brands'] as List<dynamic>;
        for (var brandCategory in brandsList) {
          brands.add(BrandCategory.fromJson(brandCategory));
        }
      } else {
        print('Http No success!');
      }
    } catch (error) {
      throw error.toString();
    }
    return brands;
  }
}

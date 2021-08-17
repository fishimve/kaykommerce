import 'package:kaykommerce/models/product.dart';

class Order {
  final String? id;
  final double amount;
  final List<Product> products;
  final DateTime? dateTime;

  Order({
    this.id,
    required this.amount,
    required this.products,
    this.dateTime,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'amount': amount,
        'dateTime': dateTime,
        'products': List.generate(
          products.length,
          (index) => {
            'id': products[index].id,
            'name': products[index].name,
            'currentPrice': products[index].currentPrice,
            'brandName': products[index].brandName,
            'imageUrl': products[index].imageUrl,
            'quantity': products[index].quantity,
          },
        ),
      };

  Order.fromMap(Map<String, dynamic> map, String id)
      : id = id,
        amount = map['amount'] ?? 0.0,
        dateTime = map['dateTime'].toDate(),
        products = List.generate(
          (map['products'] as List).length,
          (index) => Product.fromMap((map['products'] as List)[index]),
        );
}

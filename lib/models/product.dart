class Product {
  final String id;
  final String name;
  final double currentPrice;
  final String brandName;
  final String imageUrl;
  final int quantity;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'currentPrice': currentPrice,
        'brandName': brandName,
        'imageUrl': imageUrl,
        'quantity': quantity,
      };

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'] == null ? '' : json['id'].toString(),
        name = json['name'] ?? '',
        currentPrice = json['price']['current']['value'] ?? '',
        brandName = json['brandName'] ?? '',
        imageUrl = json['imageUrl'] ?? '',
        quantity = 1;

  Product.fromMap(Map<String, dynamic> map)
      : id = map['id'] ?? '',
        name = map['name'] ?? '',
        currentPrice = map['currentPrice'] ?? '',
        brandName = map['brandName'] ?? '',
        imageUrl = map['imageUrl'] ?? '',
        quantity = map['quantity'];
}

class BrandCategory {
  final String id;
  final String title;
  final List<Brand> brands;

  BrandCategory.fromJson(Map<String, dynamic> json)
      : id = json['id'] == null ? '' : json['id'].toString(),
        title = json['content']['title'] ?? '',
        brands = List.generate(
          (json['children'] as List).length,
          (index) => Brand.fromJson(
            (json['children'] as List)[index],
          ),
        );
}

class Brand {
  final String id;
  final String title;

  Brand.fromJson(Map<String, dynamic> json)
      : id = json['link']['categoryId'] == null
            ? ''
            : json['link']['categoryId'].toString(),
        title = json['content']['title'] ?? '';
}

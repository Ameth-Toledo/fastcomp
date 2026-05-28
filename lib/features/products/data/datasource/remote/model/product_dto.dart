class ProductDto {
  final String id;
  final String brand;
  final String name;
  final String category;
  final double price;
  final int stock;
  final String condition;
  final bool featured;
  final String? description;
  final List<String> specs;
  final String? imageUrl;
  final String addedAt;

  const ProductDto({
    required this.id,
    required this.brand,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.condition,
    required this.featured,
    this.description,
    required this.specs,
    this.imageUrl,
    required this.addedAt,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) => ProductDto(
        id: json['id'],
        brand: json['brand'],
        name: json['name'],
        category: json['category'],
        price: (json['price'] as num).toDouble(),
        stock: json['stock'],
        condition: json['condition'],
        featured: json['featured'] ?? false,
        description: json['description'],
        specs: (json['specs'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        imageUrl: json['imageUrl'],
        addedAt: json['addedAt'],
      );
}

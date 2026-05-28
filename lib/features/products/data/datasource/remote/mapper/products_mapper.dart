import '../../../../domain/entities/product.dart';
import '../../../../domain/entities/product_category.dart';
import '../../../../domain/entities/product_condition.dart';
import '../model/product_dto.dart';

extension ProductDtoMapper on ProductDto {
  Product toEntity() => Product(
        id: id,
        brand: brand,
        name: name,
        category: ProductCategory.fromString(category),
        price: price,
        stock: stock,
        condition: ProductCondition.fromString(condition),
        featured: featured,
        description: description,
        specs: specs,
        imageUrl: imageUrl,
        addedAt: addedAt,
      );
}

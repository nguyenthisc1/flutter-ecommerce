
class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValue;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValue,
  });

  // EMPTY HELPER FUNCTION
  static ProductVariationModel empty() => ProductVariationModel(id: '', attributeValue: {});

  // TO JSON FORMAT
  toJson() {
    return {
      'Id': id,
      'SKU': sku,
      'Image': image,
      'Description': description,
      'Price': price,
      'SalePrice': salePrice,
      'Stock': stock,
      'AttributeValue': attributeValue,
    };
  }

  // MAP JSON ORIENTED DOCUMENT SNAPSHOT FROM FIREBASE 
  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    return ProductVariationModel(
      id: data['Id'] ?? '',
      sku: data['SKU'] ?? '',
      image: data['Image'] ?? '',
      description: data['Description'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      stock: data['Stock'] ?? 0,
      attributeValue: Map<String, String>.from(data['AttributeValue']),
    );
  }
}

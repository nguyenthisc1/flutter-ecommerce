class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({
    this.name,
    this.values,
  });

  // EMPTY HELPER FUNCTION
  static ProductAttributeModel empty() => ProductAttributeModel(name: '', values: []);

  // TO JSON FORMAT
  toJson() {
    return {
      'Name': name,
      'Values': values,
    };
  }

  // MAP JSON ORIENTED DOCUMENT SNAPSHOT FROM FIREBASE
  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isEmpty) return ProductAttributeModel();
    return ProductAttributeModel(
      name: data['Name'],
      values: List<String>.from(data['Values']),
    );
  }
}

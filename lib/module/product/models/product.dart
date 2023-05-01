class Product {
  String productId;
  String name;
  String origin;
  String? image;
  Map<String, dynamic>? location;
  Map<String, dynamic>? sensors;

  Product({
    required this.productId,
    required this.name,
    required this.origin,
    this.image,
    this.location,
    this.sensors,
  });
}

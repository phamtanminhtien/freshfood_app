class Product {
  String productId;
  String name;
  String origin;
  int? status;
  String? image;
  Map<String, dynamic>? location;
  Map<String, dynamic>? sensors;
  List<dynamic>? log;

  Product({
    required this.productId,
    required this.name,
    required this.origin,
    this.status,
    this.image,
    this.location,
    this.sensors,
    this.log,
  });
}

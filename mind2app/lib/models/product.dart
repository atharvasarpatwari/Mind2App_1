class Product {
  final String id;
  final String name;
  final double price;
  final String category;
  final String? description;
  final String? imageDataUrl; // BASE64

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.description,
    this.imageDataUrl,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "category": category,
        "description": description,
        "imageDataUrl": imageDataUrl,
      };

  factory Product.fromJson(Map<String, dynamic> j) => Product(
        id: j["id"],
        name: j["name"],
        price: (j["price"] as num).toDouble(),
        category: j["category"],
        description: j["description"],
        imageDataUrl: j["imageDataUrl"],
      );
}
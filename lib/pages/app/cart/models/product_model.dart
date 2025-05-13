class Product {
  final String id;
  final String name;
  final String image;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  // Convert from JSON (if you're fetching data from Firestore)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: (json['price'] as num).toDouble(), // Ensure it's double
    );
  }

  // Convert to JSON (if you're saving data to Firestore)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
    };
  }
}

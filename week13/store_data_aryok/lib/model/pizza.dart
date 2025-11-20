class Pizza {
  final int id;
  final String pizzaName;
  final String description;
  final double price;
  final String imageUrl;

  Pizza({
    required this.id,
    required this.pizzaName,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  // Factory constructor untuk konversi dari JSON (deserialization)
  // dengan error handling untuk data yang tidak konsisten
  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: int.tryParse(json['id'].toString()) ?? 0,
      pizzaName: json['pizzaName']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      imageUrl: json['imageUrl']?.toString() ?? '',
    );
  }

  // Method untuk konversi ke JSON (serialization)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pizzaName': pizzaName,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}

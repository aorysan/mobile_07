// Konstanta untuk kunci JSON
const String keyId = 'id';
const String keyPizzaName = 'pizzaName';
const String keyDescription = 'description';
const String keyPrice = 'price';
const String keyImageUrl = 'imageUrl';

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
      id: int.tryParse(json[keyId].toString()) ?? 0,
      pizzaName: json[keyPizzaName]?.toString() ?? '',
      description: json[keyDescription]?.toString() ?? '',
      price: double.tryParse(json[keyPrice].toString()) ?? 0.0,
      imageUrl: json[keyImageUrl]?.toString() ?? '',
    );
  }

  // Method untuk konversi ke JSON (serialization)
  Map<String, dynamic> toJson() {
    return {
      keyId: id,
      keyPizzaName: pizzaName,
      keyDescription: description,
      keyPrice: price,
      keyImageUrl: imageUrl,
    };
  }
}

class MelhorEnvio {
  final String name;
  final String price;
  final int deliveryTime;

  MelhorEnvio({
    required this.name,
    required this.price,
    required this.deliveryTime,
  });

  factory MelhorEnvio.fromJson(Map<String, dynamic> json) {
    return MelhorEnvio(
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      deliveryTime: json['delivery_time'] ?? 0,
    );
  }
}

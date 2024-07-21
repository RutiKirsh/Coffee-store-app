class Coffee {
  final String name;
  final double price;
  final String imagePath;
  int quantity;

  Coffee({
    required this.name,
    required this.price,
    required this.imagePath,
    this.quantity = 1,
  });

   Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'image': imagePath,
    };
}

static Coffee fromMap(Map<String, dynamic> map){
  return Coffee(
    name: map['name'],
    price: map['price'],
    imagePath: map['image'],
  );
}
}

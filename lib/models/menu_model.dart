class MenuModel {
  final String id;
  final String name;
  final int price;
  final String category;
  final double discount;

  MenuModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.discount = 0.0,
  });

  int getDiscountedPrice() {
    return (price - (price * discount)).toInt();
  }

  MenuModel copyWith({
    String? id,
    String? name,
    int? price,
    String? category,
    double? discount,
  }) {
    return MenuModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      discount: discount ?? this.discount,
    );
  }
}

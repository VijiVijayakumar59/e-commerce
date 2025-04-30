class CartItemModel {
  final int id; 
  final String title;
  final double price;
  final String image;
  int quantity;

  CartItemModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    this.quantity = 1,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }
}


///amma indddd
class ProductsModel {
  int? id;
  String name;
  double price;
  int quantity;

  ProductsModel({this.id,required this.name,required this.price, required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity
    };
  }

  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }
}
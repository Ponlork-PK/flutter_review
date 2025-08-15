class ProductsModel {
  int? id;
  String name;
  double price;

  ProductsModel({this.id,required this.name,required this.price});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price
    };
  }

  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      name: map['name'],
      price: map['price'],
    );
  }
}
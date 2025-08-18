import 'package:flutter_review/core/db/local_database.dart';
import 'package:flutter_review/models/products_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  var productList = <ProductsModel>[].obs;

  final RxnInt editId = RxnInt();

  @override
  void onInit() async {
    super.onInit();
    loadProduct();
  }

  void loadProduct() async {
    final data = await LocalDatabase().getProducts();
    productList.value = data;
  }

  Future<void> addProducts(ProductsModel products) async {
    await LocalDatabase().insertProducts(products);
    loadProduct();
  }

  void deleteProducts(int id) async {
    await LocalDatabase().deleteProducts(id);
    loadProduct();
  }

  void editProducts(int id) async {
    editId.value = id;
  }

  Future<void> updateProducts(ProductsModel product) async {
    await LocalDatabase().updateProducts(product);
    loadProduct();
    editId.value = null;
  }
}
import 'package:flutter_review/core/db/local_database.dart';
import 'package:flutter_review/models/emp_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  var productList = <EmpModel>[].obs;

  @override
  void onInit() async {
    loadProduct();
    super.onInit();
  }


  // Future<LocalDatabase> loadProduct() async {
  //   var list = await LocalDatabase.;
  //   productList.assignAll(list);
  // }

  void loadProduct() async{
    final data = await LocalDatabase().getProducts();
    productList.value = data;
  }

  void addProducts(EmpModel products) async {
    await LocalDatabase().addProducts(products);
    loadProduct();
  }

  void deleteProducts(String id) async {
    await LocalDatabase().deleteProducts(id);
    loadProduct();
  }
}
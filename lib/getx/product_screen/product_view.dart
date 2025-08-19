import 'package:flutter/material.dart';
import 'package:flutter_review/getx/product_screen/product_controller.dart';
import 'package:flutter_review/models/products_model.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  final ProductController controller = Get.put(ProductController());
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            centerTitle: true,
            title: Text(
              'Product Screen',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              spacing: 10,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Product Name'),
                ),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Price',
                  ),
                ),
                TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Quantity'),
                ),
                Obx(() {
                  final isEdited = controller.editId.value != null;
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.deepPurple,
                    ),
                    onPressed: () async {
                      final name = nameController.text.trim();
                      final price = double.tryParse(priceController.text.trim()) ?? 0.0;
                      final quantity = int.tryParse(quantityController.text.trim()) ?? 0;
                      if( name.isEmpty || price <= 0 || quantity <= 0) return;
                      if(isEdited) {
                        await controller.updateProducts(ProductsModel(id: controller.editId.value!, name: name, price: price, quantity: quantity));
                      } else {
                        await controller.addProducts(ProductsModel( name: name, price: price, quantity: quantity));
                      }
                      nameController.clear();
                      priceController.clear();
                      quantityController.clear();
                    },
                    child: Text(
                      isEdited ? 'Save' : 'Add Product',
                      style: TextStyle(color: Colors.white),
                    ));
                }),
                Expanded(
                  child: Obx(() => ListView.builder(
                      itemCount: controller.productList.length,
                      itemBuilder: (context, index) {
                        final product = controller.productList[index];
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Product Name: ${product.name}',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Price: \$${product.price.toString()}',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Quantity: ${product.quantity.toString()}',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          nameController.text = product.name;
                                          priceController.text = product.price.toString();
                                          quantityController.text = product.quantity.toString();
                                          if( product.id != null ) {
                                            controller.editId.value = product.id;
                                          }
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.deepPurple,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          controller.deleteProducts(product.id!);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),)
                ),
              ],
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_review/getx/product_screen/product_controller.dart';
import 'package:flutter_review/models/products_model.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  final ProductController controller = Get.put(ProductController());

  final _formKey = GlobalKey<FormState>();
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
            leading: IconButton(
              onPressed: (){
                nameController.clear();
                priceController.clear();
                quantityController.clear();
                controller.editId.value = null;
                Get.back();
              }, 
              icon: Icon(Icons.arrow_back_ios)
            ),
            title: Text('Product SQLite'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 10,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Product Name'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter product name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Price',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter price';
                      }
                      final price = double.tryParse(value);
                      if (price == null) {
                        return 'Price must be a number!';
                      }
                      if(price <= 0) {
                        return 'Price must be greater than 0!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Quantity'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter quantity';
                      }
                      final quantity = int.tryParse(value);
                      if (quantity == null) {
                        return 'Quantity must be a number!';
                      }
                      if(quantity <= 0) {
                        return 'Quantity must be greater than 0!';
                      }
                      return null;
                    },
                  ),
                  Obx(() {
                    final isEdited = controller.editId.value != null;
                    return ElevatedButton(
                      onPressed: () async {
                        if( _formKey.currentState!.validate()) {
                          final name = nameController.text.trim();
                          final price = double.tryParse(priceController.text.trim()) ?? 0.0;
                          final quantity = int.tryParse(quantityController.text.trim()) ?? 0;
                          
                          if(isEdited) {
                            await controller.updateProducts(ProductsModel(id: controller.editId.value!, name: name, price: price, quantity: quantity));
                          } else {
                            await controller.addProducts(ProductsModel( name: name, price: price, quantity: quantity));
                          }
                          nameController.clear();
                          priceController.clear();
                          quantityController.clear();
                        }
                      },
                      child: Text(isEdited ? 'Save' : 'Add Product'));
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
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
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
                                            showDialog(
                                              context: context, 
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.grey.withAlpha(255),
                                                  title: Text('Delete Product'),
                                                  content: Text('Are you sure you want to delete this product?'),
                                                  actions: [
                                                    TextButton(
                                                      child: Text('Cancel'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text('Delete', style: TextStyle(color: Colors.red),),
                                                      onPressed: () {
                                                        controller.deleteProducts(product.id!);
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                            // controller.deleteProducts(product.id!);
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
          ),
        ));
  }
}

import 'package:coffee_app/models/coffee.dart';
import 'package:coffee_app/models/coffee_shop.dart';
import 'package:coffee_app/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../componants/coffee_tile.dart';

class CoffeeManager extends StatefulWidget {
  State<CoffeeManager> createState() => _CoffeeManagerState();
}

class _CoffeeManagerState extends State<CoffeeManager> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageController =
      TextEditingController(text: 'lib/images/');
  final ProductService productService = ProductService();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
      ),
      body: Consumer<CoffeeShop>(
        builder: (context, value, child) => Container(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: 'Product Name'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(hintText: 'Product Price'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _imageController,
                  decoration: InputDecoration(hintText: 'Image Path'),
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                       productService.addProduct(
                        _nameController.text,
                        double.parse(_priceController.text),
                        _imageController.text);
                    });
                  },
                  child: Text('Add Product'),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: value.coffeeShop,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error.toString()}');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('Loading...');
                      }
                      return ListView(
                        
                        children: snapshot.data!
                            .map<Widget>(
                              (coffee) => Container(
                                padding: EdgeInsets.all(20),
                                child: ListTile(
                                  leading: Image.asset(coffee.imagePath),
                                  title: Text(
                                    coffee.name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red,),
                                    onPressed: () => setState(() {
                                      productService.deleteProduct(coffee.name);
                                    }),
                                  ),                                 
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

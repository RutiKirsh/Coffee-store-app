import 'package:coffee_app/models/coffee_shop.dart';
import 'package:coffee_app/pages/coffe_oreder_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../componants/coffee_tile.dart';
import '../models/coffee.dart';

class ShopScreen extends StatefulWidget{
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  void goToCoffeePage(Coffee coffee){
    Navigator.push(context,
    MaterialPageRoute(builder: 
    (context)=> CoffeeOrderScreen(coffee: coffee)));

  }
  Widget build(BuildContext context){
   return Consumer<CoffeeShop>(
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 25,
              top: 25,
            ),
            child: Text(
              'How do you like your coffee?',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: StreamBuilder(stream: value.coffeeShop, builder: (context, snapshot) {
              if(snapshot.hasError){
                return Text('Error: ${snapshot.error.toString()}');
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return Text('Loading...');
              }
              return ListView(
                children: snapshot.data!.map<Widget>((coffee) => CoffeeTile(
                  coffee: coffee,
                  onPressed: () => goToCoffeePage(coffee),)).toList(),
              );
              },
              ),
              
            ),
        ]
          )
        
      );
    
  }
}
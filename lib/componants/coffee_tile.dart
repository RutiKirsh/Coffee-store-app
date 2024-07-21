import 'package:coffee_app/models/coffee.dart';
import 'package:flutter/material.dart';

class CoffeeTile extends StatelessWidget{
  final Coffee coffee;
  final void Function()? onPressed;

 const CoffeeTile({required this.coffee, required this.onPressed});

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.only(left: 25,right: 25, bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: ListTile(
        leading: Image.asset(coffee.imagePath),
        title: Padding(padding: EdgeInsets.only(bottom: 8),
        child: Text(coffee.name, style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ),
        subtitle: Text('\$${coffee.price}'),
        trailing: IconButton(icon: Icon(Icons.arrow_forward, color: Colors.brown[300],),
        onPressed: onPressed,),
        
      ),
    );
  }
}
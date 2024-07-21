import 'package:coffee_app/componants/coffee_tile.dart';
import 'package:coffee_app/componants/my_button.dart';
import 'package:coffee_app/componants/my_drawer.dart';
import 'package:coffee_app/models/coffee.dart';
import 'package:coffee_app/models/coffee_shop.dart';
import 'package:coffee_app/pages/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  _CartScreenState createState() => _CartScreenState();
}



class _CartScreenState extends State<CartScreen> {

void _clearCart(){
  setState(() {
    Provider.of<CoffeeShop>(context, listen: false).clearCart();
  });
}
// void _calculateTotal(){
//   double total = 
// }


  Widget build(BuildContext context) {
    MyDrawer();
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Consumer<CoffeeShop>(
        builder: (context, value, child) { 
          double totalPrice = value.userCart.fold(0, (sum, item) => sum + item.price*item.quantity);
          int totalQuantity = value.userCart.fold(0, (sum, item) => sum + item.quantity);
          return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: value.userCart.length,
                padding: EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Image.asset(value.userCart[index].imagePath),
                        title: Text(value.userCart[index].name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        subtitle: Text('Quantity: ${value.userCart[index].quantity}.\n Total: ${value.userCart[index].price*value.userCart[index].quantity}'),
                        
                        trailing: IconButton(
                          icon: Icon(Icons.cancel),
                           onPressed: ()=>
                           Provider.of<CoffeeShop>(context, listen: false).removeItemFromCart(value.userCart[index], value.userCart[index].quantity),),
                      ),
                      
                    ),
                  );
                  
                },
              ),
            ),
            SizedBox(height: 20,),
            Text('Total Price: ${totalPrice}'),
            SizedBox(height: 10,),
            Text('Total Quantity: ${totalQuantity}'),

            SizedBox(height: 30,),
            MyButton(text: 'Pay now', onTap: (){
              Navigator.push(context,
               MaterialPageRoute(builder:
                (context) => PaymentScreen(onPayment: _clearCart)));
            })
          ],
        );
        }
      ),
    );
  }
}

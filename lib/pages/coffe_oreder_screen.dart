import 'package:coffee_app/componants/my_button.dart';
import 'package:coffee_app/componants/my_chip.dart';
import 'package:coffee_app/const.dart';
import 'package:coffee_app/models/coffee_shop.dart';
import 'package:flutter/material.dart';
import 'package:coffee_app/models/coffee.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';

class CoffeeOrderScreen extends StatefulWidget {
  final Coffee coffee;

  CoffeeOrderScreen({required this.coffee});

  State<CoffeeOrderScreen> createState() => _CoffeeOrderScreenState();
}

class _CoffeeOrderScreenState extends State<CoffeeOrderScreen> {
  int quentity = 1;
  late ConfettiController _confettiController;

  void initState(){
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 3));
  }

  final List<bool> _sizeSelection = [true, false, false];
  void selectSize(String size) {
    setState(() {
      _sizeSelection[0] = size == 'S';
      _sizeSelection[1] = size == 'M';
      _sizeSelection[2] = size == 'L';
    });
  }

  void addToCart() {
    if (quentity > 0) {
      Provider.of<CoffeeShop>(context, listen: false)
          .addItemToCart(widget.coffee, quentity);
          _confettiController.play();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.brown,
          title: Text(
            "Successfuly added to cart",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, true);
              },
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ).then((_){
        _confettiController.stop();
    });
    }
  }

  void increament() {
    setState(() {
      if (quentity < 10) {
        quentity++;
      }
    });
  }

  void decrement() {
    setState(() {
      if (quentity > 1) {
        quentity--;
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey[900]),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(widget.coffee.imagePath, height: 120),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      Text(
                        'Q U A N T I T Y',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: decrement,
                            icon: Icon(Icons.remove),
                            color: Colors.grey,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: 60,
                            padding: EdgeInsets.all(10),
                            child: Center(
                                child: Text(
                              quentity.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.brown[800],
                                fontSize: 30,
                              ),
                            )),
                          ),
                          IconButton(
                            onPressed: increament,
                            icon: Icon(Icons.add_circle),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'S I Z E',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => selectSize('S'),
                        child: MyChip(text: 'S', isSelected: _sizeSelection[0]),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () => selectSize('M'),
                        child: MyChip(text: 'M', isSelected: _sizeSelection[1]),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () => selectSize('L'),
                        child: MyChip(text: 'L', isSelected: _sizeSelection[2]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  MyButton(text: 'Add to cart', onTap: addToCart)
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const[
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.blue,
                Colors.indigo,
                Colors.purple,
              ],
            ),
          )
        ],
      ),
    );
  }
}

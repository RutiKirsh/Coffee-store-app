import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentScreen extends StatefulWidget {
  final VoidCallback onPayment;
  PaymentScreen({required this.onPayment});

  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cvv = '';
  String cardHolderName = '';
  bool isCvvFocused = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvv,
                showBackView: isCvvFocused,
                onCreditCardWidgetChange: (CreditCardBrand){}
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      CreditCardForm(
                        cardNumber: cardNumber,
                         expiryDate: expiryDate,
                          cardHolderName: cardHolderName,
                           cvvCode: cvv,
                            onCreditCardModelChange: onCreditCardModelChange,
                             formKey: formKey
                             ),
                             SizedBox(height: 20,),
                             ElevatedButton(
                              onPressed: (){
                                if(formKey.currentState!.validate()){
                                  widget.onPayment();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Payment successful.'),
                                      ),
                                    );
                                    Navigator.pop(context);
                                    // Navigator.pop(context, true);

                                }
                                else{
                                  print('invalid');
                                }
                              },
                               child: Container(
                                margin: EdgeInsets.all(8),
                                child: Text('Validate', style: TextStyle(color: Colors.white, fontSize: 18),),
                               ),
                               ),
                    ],),
                  ),
                )
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel model){
    setState(() {
      cardNumber = model.cardNumber;
      expiryDate = model.expiryDate;
      cardHolderName = model.cardHolderName;
      cvv = model.cvvCode;
      isCvvFocused = model.isCvvFocused;
    });

  }
    

}

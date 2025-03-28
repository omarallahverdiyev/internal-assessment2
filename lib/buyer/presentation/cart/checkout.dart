import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internal_assessment_app/buyer/domain/cart.dart';
import 'package:internal_assessment_app/buyer/presentation/cart/address_form.dart';
import 'package:internal_assessment_app/buyer/presentation/cart/address_model.dart';
import 'package:internal_assessment_app/buyer/presentation/cart/selection_buttons.dart';
import 'package:internal_assessment_app/buyer/presentation/cart/thanks_screen.dart';
import 'package:internal_assessment_app/order/order_model.dart' as app_order;
import 'package:internal_assessment_app/utils/firebase_upload/order_upload.dart';
import 'package:intl/intl.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key, required this.cart});

  final Cart cart;

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  late AddressModel savedAddress;

  @override
  void initState() {
    super.initState();
    savedAddress = AddressModel(
      addressLine1: '',
      phoneNumber: '',
      zipCode: '',
      city: '',
    );
  }

  void _processCheckout() {
    if (selectedIndex == 3 && addressFormKey.currentState != null) {
      if (addressFormKey.currentState!.validate()) {
        addressFormKey.currentState!.save(); // Triggers onSaved in AddressForm
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill out the address form.')),
        );
        return; // Stop further processing if the form is invalid
      }
    }

    final nipFieldValue = _nipFieldController.text;

    if (nipFieldValue.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid NIP number.')),
      );
      return; // Stop further processing if NIP is empty
    }
    int orderNumber = 0;
    FirebaseFirestore.instance
          .collection('counters')
          .doc('orders')
          .get()
          .then((doc) {
        setState(() {
          orderNumber = doc.get('count') + 1;
        });
      });

    // Proceed with creating the order
    final toBeAddedOrder = app_order.Order(
      items: widget.cart.orderItems,
      totalPrice: widget.cart.totalPrice,
      totalPriceAfterTaxes: widget.cart.totalPriceAfterTaxes,
      dateOfOrder: DateTime.now(),
      paymentStatus: app_order.PaymentStatus.pending,
      deliveryStatus: app_order.DeliveryStatus.ordered,
      addressLine1: selectedIndex == 3 ? savedAddress.addressLine1 : 'Pickup',
      phoneNumber: selectedIndex == 3 ? savedAddress.phoneNumber : 'N/A',
      zipCode: selectedIndex == 3 ? savedAddress.zipCode : 'N/A',
      city: selectedIndex == 3 ? savedAddress.city : 'N/A',
      nip: nipFieldValue,
      uid: FirebaseAuth.instance.currentUser!.uid,
      orderNumber: orderNumber
    );

    final lastOrderDate = DateTime.now(); 
    OrderUpload().uploadToFirebase(context, mounted, toBeAddedOrder, lastOrderDate);
    

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ThanksScreen()),
    );
  }

  final addressFormKey = GlobalKey<FormState>();
  var selectedIndex = 0;
  final TextEditingController _nipFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
            children: [
              Card(
                child: SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Text('Netto'),
                            const Spacer(
                              flex: 1,
                            ),
                            Text(
                              NumberFormat.currency(symbol: '\$')
                                  .format(widget.cart.totalPrice),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Text('Brutto'),
                            Text(
                              NumberFormat.currency(symbol: '\$')
                                  .format(widget.cart.totalPriceAfterTaxes),
                            ),
                            Text(
                              widget.cart.totalPriceAfterTaxes.toString(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    SelectionButtons(
                      onIndexChanged: (index) {
                        setState(
                          () {
                            selectedIndex = index;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              selectedIndex == 3
                  ? AddressForm(
                      addressFormKey: addressFormKey,
                      onSave: (address) {
                        setState(() {
                          savedAddress = address;
                        });
                      })
                  : const Text('Pickup selected'),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'NIP',
                ),
                controller: _nipFieldController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                onSubmitted: (nipFieldValue) {
                  setState(() {
                    _nipFieldController.text = nipFieldValue;
                  });
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    _processCheckout();
                    // final toBeAddedOrder = app_order.Order(
                    //     items: widget.cart.orderItems,
                    //     totalPrice: widget.cart.totalPrice,
                    //     totalPriceAfterTaxes: widget.cart.totalPriceAfterTaxes,
                    //     dateOfOrder: DateTime.now(),
                    //     paymentStatus: app_order.PaymentStatus.pending,
                    //     deliveryStatus: app_order.DeliveryStatus.ordered,
                    //     addressLine1: savedAddress.addressLine1,
                    //     phoneNumber: savedAddress.phoneNumber,
                    //     zipCode: savedAddress.zipCode,
                    //     city: savedAddress.city,
                    //     nip: _nipFieldController.text,
                    //     uid: FirebaseAuth.instance.currentUser!.uid);
                    // OrderUpload()
                    //     .uploadToFirebase(context, mounted, toBeAddedOrder);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const Scaffold(
                    //             body: Center(
                    //                 child: Text('Thank you for your order')))));
                  },
                  child: const Text('Zamawiam z obowiązkiem zapłaty'))
            ],
          ),
        ),
      ),
    );
  }
}

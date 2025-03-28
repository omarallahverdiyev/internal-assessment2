import 'package:cloud_firestore/cloud_firestore.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:internal_assessment_app/buyer/presentation/cart/selection_buttons.dart';
import 'package:internal_assessment_app/order/order_model.dart';
import 'package:internal_assessment_app/seller/list_of_orderitems.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key, required this.order});

  final Order order;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int selectedIndexPayment = 0;
  int selectedIndexStatus = 0;

  @override
  void initState() {
    super.initState();
    if (widget.order.paymentStatus == PaymentStatus.pending) {
      selectedIndexPayment = 0;
    } else if (widget.order.paymentStatus == PaymentStatus.completed) {
      selectedIndexPayment = 1;
    } else if (widget.order.paymentStatus == PaymentStatus.failed) {
      selectedIndexPayment = 2;
    } else if (widget.order.paymentStatus == PaymentStatus.other) {
      selectedIndexPayment = 3;
    }
    if (widget.order.deliveryStatus == DeliveryStatus.ordered) {
      selectedIndexStatus = 0;
    } else if (widget.order.deliveryStatus == DeliveryStatus.fulfilled) {
      selectedIndexStatus = 1;
    } else if (widget.order.deliveryStatus == DeliveryStatus.shipping) {
      selectedIndexStatus = 2;
    } else if (widget.order.deliveryStatus == DeliveryStatus.delivered) {
      selectedIndexStatus = 3;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            child: Text(widget.order.addressLine1),
          ),
          SelectionButtons(onIndexChanged: (index) {
            setState(() {
              selectedIndexPayment = index;
              PaymentStatus newStatus;
              switch (index) {
                case 0:
                  newStatus = PaymentStatus.pending;
                  break;
                case 1:
                  newStatus = PaymentStatus.completed;
                  break;
                case 2:
                  newStatus = PaymentStatus.failed;
                  break;
                default:
                  newStatus = PaymentStatus.other;
              }
              firebase.FirebaseFirestore.instance
                  .collection('orders')
                  .doc(widget.order.key)
                  .update({'paymentStatus': newStatus.name});
            });
          }),
                    SelectionButtons(onIndexChanged: (index) {
            setState(() {
              selectedIndexStatus = index;
              DeliveryStatus newStatus;
              switch (index) {
                case 0:
                  newStatus = DeliveryStatus.ordered;
                  break;
                case 1:
                  newStatus = DeliveryStatus.fulfilled;
                  break;
                case 2:
                  newStatus = DeliveryStatus.shipping;
                  break;
                default:
                  newStatus = DeliveryStatus.delivered;
              }
              firebase.FirebaseFirestore.instance
                  .collection('orders')
                  .doc(widget.order.key)
                  .update({'deliveryStatus': newStatus.name});
            });
          }),
          Expanded(child: ListOfOrderitems(order: widget.order))
        ],
      ),
    );
  }
}

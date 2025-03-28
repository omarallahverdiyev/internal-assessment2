import 'package:flutter/material.dart';
import 'package:internal_assessment_app/buyer/presentation/my_orders.dart';
import 'package:internal_assessment_app/utils/notification_service.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My account'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await NotificationService.checkInactivity();
            },
            child: const Text('Test Inactivity Notification'),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (build) => const MyOrders()));
                },
                child: const Text('My Orders')),
          ),
        ],
      ),
    );
  }
}

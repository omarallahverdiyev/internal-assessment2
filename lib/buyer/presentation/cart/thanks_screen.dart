import 'package:flutter/material.dart';
import 'package:internal_assessment_app/buyer/presentation/buyer_tabs.dart';

class ThanksScreen extends StatelessWidget {
  const ThanksScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const BuyerTabs())),
        ),
      ),
      body: const Center(
        child: Text('Thank you for your order'),
      ),
    );
  }
}

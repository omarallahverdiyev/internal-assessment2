import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internal_assessment_app/buyer/presentation/buyer_tabs.dart';
import 'package:internal_assessment_app/seller/all_orders_screen.dart';
import 'package:internal_assessment_app/seller/seller_tabs.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    // if (FirebaseAuth.instance.currentUser != null) {
    //   if(FirebaseAuth.instance.currentUser!.uid == "wuAsjgmxjEPULrKu1SWzDDYtOw2") {
    //       return const AllOrdersScreen();
    //     } else {
    //       return const BuyerTabs();
    //     }
    // }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                _signInWithGoogle();
              },
              child: const Text("Sign in with Google"),
            ),
            ElevatedButton(
              onPressed: _bypassLogin,
              child: const Text(
                  "Button that makes you bypass the signin process and jumps you to buyer menu"),
            ),
            ElevatedButton(
              onPressed: _bypassLoginSeller,
              child: const Text(
                  "Same but for seller"),
            ),
          ],
        ),
      ),
    );
  }

  void _bypassLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BuyerTabs()));
  }

  void _bypassLoginSeller() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SellerTabs()));
  }

  Future<void> _signInWithGoogle() async {
    // Configure the Google sign-in provider
    try {
      await GoogleSignIn().signIn();

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (FirebaseAuth.instance.currentUser!.uid ==
            "wuAsjgmxjEPULrKu1SWzDDYtOgw2") {
          if (!mounted) return;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const AllOrdersScreen()));
        } else {
          if (!mounted) return;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const BuyerTabs()));
        }
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("$error")));
    }
  }
}

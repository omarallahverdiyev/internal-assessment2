import 'package:flutter/material.dart';
import 'package:internal_assessment_app/appuser/app_user.dart';
import 'package:internal_assessment_app/buyer/domain/cart.dart';
import 'package:internal_assessment_app/buyer/domain/cart_provider.dart';
import 'package:internal_assessment_app/buyer/presentation/cart/cart_screen.dart';
import 'package:internal_assessment_app/buyer/presentation/categories_screen.dart';
import 'package:internal_assessment_app/buyer/presentation/home_screen.dart';
import 'package:internal_assessment_app/buyer/presentation/my_account_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuyerTabs extends ConsumerStatefulWidget {
  const BuyerTabs({super.key});



  @override
  ConsumerState<BuyerTabs> createState() => _TabsState();
}

class _TabsState extends ConsumerState<BuyerTabs> {
  Widget activePage = const HomeScreen();
  int _selectedIndex = 0;



  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    // final orderItems = ref.watch(cartProvider); //this was supposed to be a list of orderitems but firebase gave an object
    // final Cart cart = Cart(items: orderItems); //ecf
    if (_selectedIndex == 0) {
      activePage = const HomeScreen();
    } else if (_selectedIndex == 1) {
      activePage = const CategoriesScreen();
    } else if (_selectedIndex == 2){
      activePage = const CategoriesScreen();  //i need to find the instance of user's cart so i can place it in the constructor;
    } else if (_selectedIndex == 3) {
      activePage = const MyAccountScreen();
    }
    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _selectPage,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, color: Colors.red,),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined, color: Colors.red,),
              label: "Categories"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined, color: Colors.red,),
              label: "Cart"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined, color: Colors.red,),
              label: "My account"
            ),
          ]),
    );
  }
}

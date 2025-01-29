import 'package:flutter/material.dart';
import 'package:internal_assessment_app/seller/all_orders_screen.dart';
import 'package:internal_assessment_app/seller/all_products_screen.dart';

class SellerTabs extends StatefulWidget {
  const SellerTabs({super.key});

  @override
  State<SellerTabs> createState() => _SellerTabsState();
}

class _SellerTabsState extends State<SellerTabs> {
  Widget activePage = const AllOrdersScreen();
  int _selectedIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedIndex == 0) {
      activePage = const AllOrdersScreen();
    } else if (_selectedIndex == 1) {
      activePage = const AllProductsScreen();
    }
    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _selectPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.red[300],
            ),
            label: "Orders",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.inventory_2_outlined,
                color: Colors.red[300],
              ),
              label: "Products"),
        ],
      ),
    );
  }
}

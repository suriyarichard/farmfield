import 'dart:io';

import 'package:farmfield/widgets/snackbar/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/grocery_item_tile.dart';
import '../model/cart_model.dart';
import 'cart_page.dart';

class Ecommer extends StatefulWidget {
  const Ecommer({super.key});

  @override
  State<Ecommer> createState() => _EcommerState();
}

class _EcommerState extends State<Ecommer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // leading: IconButton(
      //   //     icon: const Icon(Icons.close_rounded, color: Colors.black),
      //   //     onPressed: () {
      //   //       Navigator.pushNamed(context, '/return');
      //   //     }),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   // title: Text(
      //   //   '',
      //   //   style: TextStyle(
      //   //     fontSize: 16,
      //   //     color: Colors.grey[700],
      //   //   ),
      //   // ),
      //   // centerTitle: false,
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 24.0),
      //       child: IconButton(
      //           icon: const Icon(
      //             Icons.close_rounded,
      //             color: Colors.red,
      //             size: 40,
      //           ),
      //           onPressed: () {
      //             // exit(0);
      //             Navigator.pushNamed(context, '/return');
      //           }),
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const CartPage();
            },
          ),
        ),
        child: const Icon(Icons.shopping_bag),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 48),

          // good morning bro
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text('Good morning,'),
          ),

          const SizedBox(height: 4),

          // Let's order fresh items for you
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Let's provide you best solution for you",
              // order fresh items for you",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(),
          ),

          const SizedBox(height: 24),

          // categories -> horizontal listview
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Fresh Items",
              style: TextStyle(
                //fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),

          // recent orders -> show last 3
          Expanded(
            child: Consumer<CartModel>(
              builder: (context, value, child) {
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.shopItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.2,
                  ),
                  itemBuilder: (context, index) {
                    return GroceryItemTile(
                        itemName: value.shopItems[index][0],
                        itemPrice: value.shopItems[index][1],
                        imagePath: value.shopItems[index][2],
                        color: value.shopItems[index][3],
                        onPressed: () {
                          Provider.of<CartModel>(context, listen: false)
                              .addItemToCart(index);
                          showSnackBar(context, "Item added to cart");
                        });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

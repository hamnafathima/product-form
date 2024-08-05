import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> productList = [];

  double calculateSubTotal() {
    double subTotal = 0;
    for (var product in productList) {
      double price = double.tryParse(product['price']) ?? 0.0;
      subTotal += price;
    }
    return subTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.deepOrange.shade100,
                          ),
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            initialValue: productList[index]['name'],
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Name Product',
                            ),
                            onChanged: (value) {
                              setState(() {
                                productList[index]['name'] = value;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.deepOrange.shade100,
                          ),
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            initialValue: productList[index]['price'],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefix: Text('\u{20B9} '),
                              hintText: 'Price',
                            ),
                            onChanged: (value) {
                              setState(() {
                                productList[index]['price'] = value;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 25),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            productList.removeAt(index);
                          });
                        },
                        icon: const Icon(Icons.close),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(),
                Row(
                  children: [
                    const Text(
                      'Subtotal',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Spacer(),
                    Text(
                      '\u{20B9} ${calculateSubTotal().toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Place Order',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 120.0),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
          onPressed: () {
            setState(() {
              productList.add({'name': '', 'price': '0.0'});
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

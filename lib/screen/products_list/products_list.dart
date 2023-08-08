import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketpet/models/product/product.dart';
import 'package:marketpet/screen/product_details/product_details.dart';

import '../../models/category/category_services.dart';
import '../../utils/capitalizeFirstLetter.dart';
import 'package:intl/intl.dart';

final oCcy = NumberFormat("#,##0.00", "en_US");

class ProductsList extends StatefulWidget {
  ProductsList({Key? key, this.id, this.name}) : super(key: key);

  String? name;
  int? id;

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _categories = [];
  List<DocumentSnapshot> _products = [];

  Map<dynamic, dynamic> resultReduce = {};
  

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
   
      List<DocumentSnapshot> categories = await getCategory();

      List<DocumentSnapshot> products = await getProducts();

      setState(() {
        _categories = categories;
        _products = products;
      });
    
  }

  Future<List<DocumentSnapshot>> getCategory() async {
    QuerySnapshot snapshot = await _firestore.collection('category').get();
    return snapshot.docs;
  }

  Future<List<DocumentSnapshot>> getProducts() async {
    QuerySnapshot snapshot = await _firestore.collection('product').where('idStore', isEqualTo: widget.id.toString())
        .get();
    return snapshot.docs;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        title: Text(widget.name!),
      ),
      body: ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          DocumentSnapshot category = _categories[index];
          String categoryName = category['description'];
         
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      capitalizeFirstLetter(categoryName),
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 75, 74, 74),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'See more',
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot productItem = _products[index];

                      String name = productItem['name'];
                      double price = productItem['price'];
                      String url = productItem['url'];


                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          bottom: 20,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ProductsDetails(),
                                ));
                              },
                              child: Container(
                                  width: 200,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 240, 240, 240),
                                      width: 2.0,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                          width: 200,
                                          height: 128,
                                          decoration:  BoxDecoration(
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(6.0),
                                              topRight: Radius.circular(6.0),
                                            ),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    url)), // <--- .image added here
                                          )),
                                      Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            verticalDirection:
                                                VerticalDirection.down,
                                            children: [
                                              Text(
                                               name,
                                                style: GoogleFonts.outfit(
                                                  fontSize: 14,
                                                  color: const Color.fromARGB(
                                                      255, 75, 74, 74),
                                                  fontWeight: FontWeight.w700,
                                            
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Color.fromARGB(
                                                        255, 246, 163, 67),
                                                    size: 16,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "4.9",
                                                      style: GoogleFonts.outfit(
                                                        fontSize: 12,
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 218, 218, 218),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                  'R\$ ${oCcy.format(price)}',
                                                    style: GoogleFonts.outfit(
                                                      fontSize: 16,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.blue.withOpacity(0.15),
        selectedIndex: 0,
        // ignore: prefer_const_literals_to_create_immutables
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.house_outlined),
            label: 'Home',
          ),
          const NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Favorites',
          ),
          const NavigationDestination(
            icon: Icon(Icons.favorite_border),
            label: 'Saved',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

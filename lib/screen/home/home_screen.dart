import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketpet/models/store/store.dart';
import 'package:marketpet/models/store/store_services.dart';
import 'package:marketpet/screen/logins/login_screen.dart';
import 'package:marketpet/screen/products_list/products_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final StoreService _transactionServices = StoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Row(children: <Widget>[
                    Text(
                      '${user!.email}',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Colors.red,
                            width: 1.0,
                          ),
                        ),
                        color: Colors.white,
                        child: Text(
                          'Sair',
                          style: GoogleFonts.outfit(
                            color: Colors.red,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ])),
              Container(
                height: 1,
                margin: const EdgeInsets.only(top: 20),
                color: const Color.fromARGB(255, 214, 217, 219),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 100,
                      width: 300,
                      child: StreamBuilder(
                        stream: _transactionServices.firestoreRef.snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> storeMap =
                                      snapshot.data!.docs[index].data()
                                          as Map<String, dynamic>;

                                  Store storeItem = Store.fromMap(storeMap);

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => ProductsList(
                                            id: int.parse(storeItem.id!),
                                            name: storeItem.name),
                                      ));
                                    },
                                    child: Container(
                                        transformAlignment: Alignment.center,
                                        width: 300,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 214, 217, 219),
                                            width: 1,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight: Radius.circular(
                                                          10)), // Image border
                                              child: SizedBox.fromSize(
                                                size: const Size(300, 250),
                                                // Image radius
                                                child: Image.network(
                                                  storeItem.url!,
                                                  fit: BoxFit.cover,
                                                  width: 300,
                                                  height: 300,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.storefront_outlined,
                                                    color: Color.fromARGB(
                                                        255, 75, 74, 74),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    storeItem.name!,
                                                    style: GoogleFonts.outfit(
                                                      fontSize: 16,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 75, 74, 74),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  );
                                });
                          } else {
                            return const Text('Não tem dados');
                          }
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

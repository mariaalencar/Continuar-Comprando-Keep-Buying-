import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductsDetails extends StatelessWidget {
  const ProductsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
        title: const Text('Essentials Mens Short - Sleeve Crewneck T-Shirt'),
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          decoration: const BoxDecoration(color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://picsum.photos/250?image=9')), // <--- .image added here
                  )),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Essentials Mens Short - Sleeve Crewneck T-Shirt',
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 246, 163, 67),
                    size: 18,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "4.9",
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 218, 218, 218),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Text(
                    "R\$ 180,00",
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      color: Colors.blue,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // create divider

              const Divider(
                color: Color.fromARGB(255, 195, 195, 195),
                height: 2,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Marca",
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Nike",
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 153, 153, 153),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Descrição",
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  SizedBox(
                    width: screenWidth * 0.75,
                    child: Text(
                      "Suspendisse feugiat odio id tincidunt molestie. Nulla pulvinar tellus nibh, quis feugiat felis suscipit et. Fusce viverra augue posuere tincidunt malesuada. Maecenas hendrerit pretium mollis. Pellentesque tristique diam enim, vel porta nisi sagittis eget. Proin vitae dui purus. Suspendisse nec tristique lacus, id tincidunt arcu. ",
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 153, 153, 153),
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ]),
      extendBody: true,
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -1),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total",
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 218, 218, 218),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "R\$ 180,00",
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Adicionar \nao carrinho",
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

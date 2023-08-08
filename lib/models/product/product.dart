import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? brand;
  String? name;
  int? categoryId;
  String? description;
  int? idStore;
  double? price;
  //método construtor para inicializar as variáveis de instância
  Product({
    this.brand,
    this.name,
    this.categoryId,
    this.description,
    this.idStore,
    this.price,
  });

  //método utilizado para armazenar dados do documento
  //obtido no Firebase
  fromDocument(DocumentSnapshot doc) {
    brand = doc.get('brand') as String;
    name = doc.get('name') as String;
    categoryId = doc.get('categoryId') as int;
    description = doc.get('description') as String;
    idStore = doc.get('idStore') as int;
    price = doc.get('price') as double;
  }

  //Método utilizado para converter as informações
  //para formato JSON, que é o formato reconhecido pelo Firebase
  Map<String, dynamic> toMap(Map<String, dynamic> data) {
    return {
      'name': name,
      'brand': brand,
      'categoryId': categoryId,
      'description': description,
      'idStore': idStore,
      'price': price,
    };
  }

  static Product fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();

    return Product(
      brand: data['brand'] ?? '',
      name: data['name'] ?? '',
      categoryId: data['categoryId'] ?? '',
      description: data['description'] ?? '',
      idStore: data['idStore'] ?? '',
      price: data['price'] ?? '',
    );
  }

  Product.fromMap(Map<String, dynamic> map) {
    categoryId = map['categoryId'];
    name = map['name'];
    idStore = map['idStore'];
    price = map['price'] as double;
    brand = map['brand'];
    description = map['description'];
  }
}

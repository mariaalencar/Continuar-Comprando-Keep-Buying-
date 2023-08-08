import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  String? id;
  String? name;
  String? url;
  //método construtor para inicializar as variáveis de instância
  Store({
    this.id,
    this.name,
    this.url,
  });

  //método utilizado para armazenar dados do documento
  //obtido no Firebase
  fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    name = doc.get('name') as String;
    url = doc.get('url') as String;
  }

  //Método utilizado para converter as informações
  //para formato JSON, que é o formato reconhecido pelo Firebase
  Map<String, dynamic> toMap(Map<String, dynamic> data) {
    return {
      'name': name,
      'url': url
    };
  }


  static Store fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();

    return Store(
      id: doc.id,
      name: data['name'] ?? '',
      url: data['url'] ?? '',
    );
  }

 Store.fromMap(Map<String, dynamic> map) {
    id = map['id'] ;
    name = map['name'];
    url = map['url'];
  }
}

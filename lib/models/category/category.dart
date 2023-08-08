import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String? id;
  String? description;

  Category({
    this.id,
    this.description,
  });

  fromDocument(DocumentSnapshot doc) {
    id = doc.get('id') as String;
    description = doc.get('description') as String;
  }

  Map<String, dynamic> toMap(Map<String, dynamic> data) {
    return {
      'id': id,
      'description': description,
    };
  }

  static Category fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();

    return Category(
      id: data['id'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Category.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    description = map['description'];
  }
}

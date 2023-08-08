import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketpet/models/store/store.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference firestoreRef;

  CategoryService() {
    firestoreRef = _firestore.collection('category');
  }

  Stream<List<dynamic>> get storesStream {
    return _firestore.collection('category').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Store.fromSnapshot(doc)).toList());
  }

  Future<List> getCategory() async {
    final snapshot = await _firestore.collection('category').get();
    final stores = snapshot.docs.map((doc) => Store.fromSnapshot(doc)).toList();
    return stores;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketpet/models/store/store.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference firestoreRef;

  ProductService() {
     firestoreRef = _firestore.collection('product');
  }
  

  Stream<List<dynamic>> get storesStream {
    return _firestore
        .collection('product')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Store.fromSnapshot(doc))
            .toList());
            
  }

  Future<List> getStores() async {
    final snapshot =
        await _firestore.collection('product').get();
    final stores = snapshot.docs
        .map((doc) => Store.fromSnapshot(doc))
        .toList();
    return stores;
  }


}

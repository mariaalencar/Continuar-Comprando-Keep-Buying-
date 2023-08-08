import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketpet/models/store/store.dart';

class StoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference firestoreRef;

  StoreService() {
     firestoreRef = _firestore.collection('store');
  }
  

  Stream<List<dynamic>> get storesStream {
    return _firestore
        .collection('stores')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Store.fromSnapshot(doc))
            .toList());
            
  }

  Future<List> getStores() async {
    final snapshot =
        await _firestore.collection('stores').get();
    final stores = snapshot.docs
        .map((doc) => Store.fromSnapshot(doc))
        .toList();
    return stores;
  }


}

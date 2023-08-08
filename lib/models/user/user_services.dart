import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketpet/models/user/user.dart';

class UserServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //método get para obter uma refência do documento da coleção de usuários (users)
  DocumentReference get firestoreRef =>
      _firestore.doc('users/${userLocal!.id}');

  //variável de instância do usuário local
  UserLocal? userLocal;

  late bool loading;

  //método utilizado para persistir o usuário no firebase/banco de dados
  Future<void> signUp(UserLocal userLocal) async {
    User? user = (await _auth.createUserWithEmailAndPassword(
      email: userLocal.email!,
      password: userLocal.password!,
    ))
        .user;
    userLocal.id = user!.uid;

    this.userLocal = userLocal;
    saveData();
  }

  //método para realizar a autenticação do usuário
  Future<bool> signIn(UserLocal userLocal) async {
    try {
      User? user = (await _auth.signInWithEmailAndPassword(
        email: userLocal.email!,
        password: userLocal.password!,
      ))
          .user;
      userLocal.id = user!.uid;
      this.userLocal = userLocal;
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('Não há usuário registrado com este email');
      } else if (e.code == 'wrong-password') {
        debugPrint('A senha informada não confere');
      }
      return Future.value(false);
    }
  }

  Future<void> saveData() async {
    await firestoreRef.set(userLocal!.toMap());
  }

  //método para realizar o logout do usuário

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> getUser() async {
    if (userLocal != null) {
      return;
    }
    final User? user = _auth.currentUser;
    final DocumentSnapshot doc = await firestoreRef.get();
    userLocal = UserLocal.fromDocument(doc);
    userLocal!.id = user!.uid;
  }
}

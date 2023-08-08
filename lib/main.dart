import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marketpet/screen/main_page.dart';

void main() async {
  const firebaseConfig = FirebaseOptions(
      apiKey: "AIzaSyA0W9_hQxpKCQ9fI2-qvqatPNeallbw5Fc",
      authDomain: "marketpet-flutter.firebaseapp.com",
      projectId: "marketpet-flutter",
      storageBucket: "marketpet-flutter.appspot.com",
      messagingSenderId: "164319439257",
      appId: "1:164319439257:web:332dae3b4bf5a861b50b08");
  if (kIsWeb) {
    await Firebase.initializeApp(options: firebaseConfig);
    // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    // FirebaseFirestore.instance.useFirestoreEmulator("localhost", 8080);
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    // FirebaseFirestore.instance.useFirestoreEmulator("localhost", 8080);
  }
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marketpet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(), //HomeScreen(),
    );
  }
}

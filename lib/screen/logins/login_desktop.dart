import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketpet/models/user/user.dart';
import 'package:marketpet/models/user/user_services.dart';
import 'package:marketpet/screen/home/home_screen.dart';
// import 'package:webflutter/view/main_page_screen.dart';

class LoginDesktop extends StatefulWidget {
  const LoginDesktop({super.key});

  @override
  State<LoginDesktop> createState() => _LoginDesktopState();
}

class _LoginDesktopState extends State<LoginDesktop> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email, password;
  bool _isChecked = false;

  UserLocal _userLocal = UserLocal();
  final UserServices _userServices = UserServices();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          // flex: 4,
          child: Image.asset(
            'assets/images/image-1.png',
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 21),
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Bem-vindo de volta!!!',
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Login para sua conta',
                  style: GoogleFonts.inter(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 35),
                Form(
                    child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      validator: (tfEmail) {
                        if (tfEmail!.isEmpty) {
                          return 'Campo deve ser preenchido!!!';
                        }
                        return null;
                      },
                      onSaved: (tfEmail) => _userLocal.email = tfEmail!,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      validator: (tfPasswd) {
                        if (tfPasswd!.isEmpty) {
                          return 'Campo deve ser preenchido!!!';
                        }
                        return null;
                      },
                      onSaved: (tfPasswd) => _userLocal.password = tfPasswd!,
                    ),
                  ],
                )),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('Lembrar-me'),
                    const Text('Esqueceu a senha?'),
                  ],
                ),
                const SizedBox(height: 30),
                TextButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 29, 109, 27)),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      bool ok = await _userServices.signIn(_userLocal);
                      if (ok) {
                        if (mounted) {
                          //mounted só funciona em stf
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color.fromARGB(255, 1, 32, 1)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Entre com Google',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pengaduan_masyarakat/RegisterPage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/login'),
      body: {
        "username": usernameController.text,
        "password": passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Berhasil: ${data['nama']}")),
      );
    } else {
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Gagal: ${data['message']}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 70),
      child: Column(
        children: [
          Image.asset('assets/images/4794658-removebg-preview.png',
              height: 250),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Belum Punya Akun?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()));
                },
                child: const Text(
                  "Daftar",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6.0,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: Form(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: usernameController,
                        decoration:
                            const InputDecoration(labelText: "Username"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration:
                            const InputDecoration(labelText: "Password"),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          if (value.length < 6) {
                            return 'Password minimal 6 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD97757),
                        ),
                        onPressed: () {
                          login(); // Panggil fungsi login
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

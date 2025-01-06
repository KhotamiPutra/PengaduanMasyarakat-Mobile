import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool _isLoading = false; 

  Future<void> register() async {
    setState(() {
      _isLoading = true; 
    });

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/register"),
        body: {
          "nik": nikController.text,
          "nama": nameController.text,
          "username": usernameController.text,
          "password": passwordController.text,
          "telp": phoneController.text,
        },
      );

      final responseBody = json.decode(response.body);

      // Menampilkan pesan sukses atau error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(responseBody['message'] ?? "Data berhasil terkirim"),
      ));

      // Kembali ke halaman sebelumnya setelah sukses
      Navigator.pop(context);
    } catch (e) {
      // Menangani error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Terjadi kesalahan: $e"),
      ));
    } finally {
      setState(() {
        _isLoading = false; // Selesai loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register Page")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
          Image.asset('assets/images/6300959-removebg-preview.png', height: 250),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6.0,
                    offset: const Offset(0, 3),
                  )
                ]
              ),
              child: Stack(
                children: [
                  Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nikController,
                            decoration: const InputDecoration(labelText: "NIK",counterText: ""),
                            maxLength: 16,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'NIK tidak boleh kosong';
                              }
                              if (value.length != 16) {
                                return 'NIK harus 16 digit';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          ),
                          TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(labelText: "Nama"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Nama tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: usernameController,
                            decoration: const InputDecoration(labelText: "Username"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Username tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(labelText: "Password"),
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
                          TextFormField(
                            controller: phoneController,
                            decoration: const InputDecoration(labelText: "Nomor Telepon"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Nomor telepon tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD97757),
                            ),
                            onPressed: _isLoading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      register();
                                    }
                                  },
                            child: const Text("Daftar",style: TextStyle(color: Colors.white),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isLoading)
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

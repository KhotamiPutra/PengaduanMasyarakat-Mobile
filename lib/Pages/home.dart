import 'package:flutter/material.dart';
import 'package:pengaduan_masyarakat/Service/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final name = await getUserName();
    setState(() {
      userName = name ?? 'User';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $userName',style: const TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFFD97757),
      ),
      body: const Center(
        child: Text('Home Page Content'),
      ),
    );
  }
}

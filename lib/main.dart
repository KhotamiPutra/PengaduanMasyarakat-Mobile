import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pengaduan_masyarakat/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Selamat Datang di Aplikasi Pengaduan Masyarakat",
            body: "Kami mendengarkan suara Anda. Suarakan aspirasi Anda sekarang!",
            image: Center(child: Image.asset('assets/images/5401383-removebg-preview.png', height: 500)),
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
              bodyTextStyle: TextStyle(fontSize: 19.0),
            ),
          ),
          PageViewModel(
            title: "Laporkan dengan Aman",
            body: "Kami berjanji akan melindungi identitas Anda dan melindungi laporan Anda dari tindakan yang tidak bertanggung jawab.",
            image: Center(child: Image.asset('assets/images/5413922-removebg-preview.png', height: 500)),
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
              bodyTextStyle: TextStyle(fontSize: 19.0),
            ),
          ),
          PageViewModel(
            title: "Aman, Terpercaya, dan Mudah",
            body: "Tekan tombol di bawah ini untuk memulai",
            image: Center(child: Image.asset('assets/images/5419956-removebg-preview.png', height: 500)),
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
              bodyTextStyle: TextStyle(fontSize: 19.0),
            ),
          ),
        ],
        onDone: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        },
        showSkipButton: true,
        skip: const Text("Skip", style: TextStyle(color: Colors.black)),
        next: const Icon(Icons.arrow_forward, color: Colors.black),
        done: const Text("Start", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        dotsDecorator: DotsDecorator(
          size:const Size(10.0, 10.0),
          activeSize:const Size(22.0, 10.0),
          activeColor: Colors.white,
          color: Colors.brown,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}



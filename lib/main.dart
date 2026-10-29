import 'package:flutter/material.dart';
import 'constants.dart';
import 'screens/portfolio_home.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moh Rafli Abbas | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        // Menggunakan warna awal gradasi agar transisi latar belakang menyatu sempurna
        scaffoldBackgroundColor: linkedinBgStart,
        colorScheme: ColorScheme.fromSeed(
          seedColor: linkedinBlue,
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const PortfolioHome(),
    );
  }
}
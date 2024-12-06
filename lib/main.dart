import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pusdatin_end/pages/page_login.dart';
import 'package:pusdatin_end/providers/providers_login.dart';
import 'package:pusdatin_end/providers/providers_pegawai.dart';
import 'package:pusdatin_end/providers/providers_dataBarang.dart';
import 'package:pusdatin_end/providers/providers_pemeliharaan.dart';
import 'package:pusdatin_end/providers/providers_peminjaman.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => ProviderPegawai()),
        ChangeNotifierProvider(create: (context) => ProviderDatabarang()),
        ChangeNotifierProvider(create: (context) => ProvidersPeminjaman()),
        ChangeNotifierProvider(create: (context) => ProviderPemeliharaan()),
        // -> Provider lain.
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login':(context) => LoginPage(),
      },
      title: 'Pusdatin App',
      theme: ThemeData(
        primaryColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: LoginPage(),
    );
  }
}

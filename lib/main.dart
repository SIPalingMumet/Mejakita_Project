import 'package:diskusi_pr1/pages/dashboard.dart';
import 'package:diskusi_pr1/pages/forgot.dart';
import 'package:diskusi_pr1/pages/diskusipr.dart';
import 'package:diskusi_pr1/pages/halaman.dart';
import 'package:diskusi_pr1/pages/history.dart';
import 'package:diskusi_pr1/pages/home.dart';
import 'package:diskusi_pr1/pages/login.dart';
import 'package:diskusi_pr1/pages/pertanyaan.dart';
import 'package:diskusi_pr1/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('savedDataBox');
  runApp(MaterialApp(
    theme: ThemeData(
        useMaterial3: true, 
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light, 
      ),
      darkTheme: ThemeData(
        useMaterial3: true, 
        colorSchemeSeed: Colors.blue,  
        brightness: Brightness.dark, 
      ),
      themeMode: ThemeMode.light, 
    initialRoute: '/homepage',
    debugShowCheckedModeBanner: false,
    routes: {
      '/homepage': (context) => const HomePage(),
      '/dashboard':(context) => const Dashboard(),
      '/login':(context) => const Login(),
      '/signup':(context) => const Signup(),
      '/forgot':(context) => const ForgotPage(),
      '/perbaikan':(context) => const Perbaikan(),
      '/home':(context) => const Home(),
      '/pertanyaan':(context) => const Pertanyaan(),
      '/history':(context) => const History(),
    },
  ));
}

 
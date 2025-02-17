import 'package:flutter/material.dart';
import 'login_page.dart'; // Assure-toi que le fichier login_page.dart est bien dans le dossier lib

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Supprime le bandeau debug
      title: 'My App', // Titre de l'application
      theme: ThemeData(
        primarySwatch: Colors.blue, // Couleur principale
        scaffoldBackgroundColor: Colors.white, // Fond général blanc
      ),
      home: LoginPage(), // Page de connexion comme écran d'accueil
    );
  }
}
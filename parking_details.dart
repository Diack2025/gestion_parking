import 'package:flutter/material.dart';
import 'profile_page.dart';

class ParkingDetailsPage extends StatefulWidget {
  final String nom;
  final String statut;

  ParkingDetailsPage({required this.nom, required this.statut});

  @override
  _ParkingDetailsPageState createState() => _ParkingDetailsPageState();
}

class _ParkingDetailsPageState extends State<ParkingDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numController = TextEditingController();
  final TextEditingController _marqueController = TextEditingController();

  int _placesDisponibles = 10; 
  final int _prixMensuel = 15000; 

  void _ajouterVehicule() {
    if (_formKey.currentState!.validate()) {
      if (_placesDisponibles > 0) {
        setState(() {
          _placesDisponibles--; 
        });

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 30),
                  SizedBox(width: 10),
                  Text("Ajout Réussi"),
                ],
              ),
              content: Text(
                "Votre véhicule a été ajouté avec succès.\n"
                "Le paiement doit se faire sur place : ${_prixMensuel.toString()} FCFA / mois.\n"
                "Places restantes : $_placesDisponibles",
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Désolé, ce parking est complet !"),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détails - ${widget.nom}"),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/M2.jpg"), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nom du Parking : ${widget.nom}",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  "Statut : ${widget.statut}",
                  style: TextStyle(fontSize: 18, color: widget.statut == "Ouvert" ? Colors.green : Colors.red),
                ),
                SizedBox(height: 10),
                Text(
                  "Places disponibles : $_placesDisponibles",
                  style: TextStyle(fontSize: 18, color: Colors.orangeAccent, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Tarif : ${_prixMensuel.toString()} FCFA / mois",
                  style: TextStyle(fontSize: 18, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _numController,
                        decoration: InputDecoration(
                          labelText: "Numéro d'immatriculation",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.directions_car, color: Colors.blue),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez entrer le numéro d'immatriculation";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _marqueController,
                        decoration: InputDecoration(
                          labelText: "Marque du véhicule",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.car_rental, color: Colors.blue),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez entrer la marque du véhicule";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _ajouterVehicule,
                        child: Text("Ajouter le véhicule"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gestion_parking/profile_page.dart';
import 'parking_details.dart';

class DashboardPage extends StatelessWidget {
  final List<Map<String, String>> parkings = [
    {"nom": "Kalaban", "statut": "Ouvert"},
    {"nom": "Quinzambougou", "statut": "Complet"},
    {"nom": "Faladjé", "statut": "Ouvert"},
    {"nom": "Hypodrome", "statut": "Fermé"},
    {"nom": "ACI", "statut": "Ouvert"},
    {"nom": "Yirimadjo", "statut": "Complet"},
    {"nom": "Djelibougou", "statut": "Ouvert"},
    {"nom": "Daoudabougou", "statut": "Fermé"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de Bord', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
          // Dégradé en arrière-plan
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue.shade800, Colors.blue.shade300],
              ),
            ),
          ),
          // Liste des parkings
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: parkings.length,
              itemBuilder: (context, index) {
                String statut = parkings[index]["statut"]!;
                Color statutColor = statut == "Ouvert"
                    ? Colors.green
                    : (statut == "Complet" ? Colors.orange : Colors.red);

                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Colors.white.withOpacity(0.9), // Fond semi-transparent pour la lisibilité
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    title: Text(
                      parkings[index]["nom"]!,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: [
                        Icon(Icons.circle, color: statutColor, size: 12),
                        SizedBox(width: 5),
                        Text(
                          "Statut : $statut",
                          style: TextStyle(color: statutColor, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue.shade700),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ParkingDetailsPage(
                            nom: parkings[index]["nom"]!,
                            statut: parkings[index]["statut"]!,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

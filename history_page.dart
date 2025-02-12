
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<String> history = [
    "Toyota Corolla - 10h30",
    "Honda Civic - 11h00",
    "Peugeot 208 - 12h15",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Historique des Entrées/Sorties")),
      body: Stack(
        children: [
          
          Positioned.fill(
            child: Image.asset(
              "assets/M5.jpg", 
              fit: BoxFit.cover,
            ),
          ),
          
          Container(
            color: Colors.black.withOpacity(0.5), 
            child: ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white.withOpacity(0.8),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(
                      history[index],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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



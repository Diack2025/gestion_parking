import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image; 

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.request();
      var photoStatus = await Permission.photos.request();
      return status.isGranted || photoStatus.isGranted;
    }
    return true;
  }

  Future<void> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profile_image');
    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  Future<void> _pickImage() async {
    bool hasPermission = await _requestStoragePermission();
    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Permission refusée !")),
      );
      return;
    }

    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', pickedFile.path);
    }
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    // Rediriger vers la page de connexion en supprimant tout l'historique de navigation
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: const Text("Profil"),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            _buildProfilePicture(),
            const SizedBox(height: 20),
            _buildProfileField(Icons.person, "Nom", "Berthe Diakaridia"),
            _buildProfileField(Icons.phone, "Téléphone", "+223 00000000"),
            _buildProfileField(Icons.location_on, "Adresse", "Bamako, Mali"),
            _buildProfileField(Icons.email, "Email", "user@example.com"),
            const SizedBox(height: 30),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: _image != null ? FileImage(_image!) : null,
          backgroundColor: Colors.grey[300],
          child: _image == null ? Icon(Icons.person, size: 60, color: Colors.white) : null,
        ),
        IconButton(
          icon: const Icon(Icons.camera_alt, color: Colors.white),
          onPressed: _pickImage,
        ),
      ],
    );
  }

  Widget _buildProfileField(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey.shade300)],
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.blue[800]),
          title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(value),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _logout(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text("Déconnexion", style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }
}


import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/services/firebase_auth_service.dart';
import 'package:chatapp/services/firebase_fire_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _disNameController = TextEditingController();
  final _picker = ImagePicker();
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Settings"),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.blue,
                  backgroundImage: CachedNetworkImageProvider(
                    FirebaseAuthService.auth.currentUser!.photoURL.toString(),
                  ),
                ),
              ],
            ),
            title: Text(
                FirebaseAuthService.auth.currentUser!.displayName.toString()),
            trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  await myDialog();
                }),
          ),
        ],
      ),
    );
  }

  Future uploadFile() async {
    if (_imageFile == null) return;
    final fileName = _imageFile!.path.split('/').last;
    final destination = 'files/$fileName';

    await FirebaseApi.uploadFile(destination, _imageFile!);
  }

  Future pickImageFromCamera() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = File(pickedImage!.path);
    });
    await uploadFile();
  }

  Future pickImageFromPhotos() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedImage!.path);
      print(pickedImage.path);
    });
    await uploadFile();
  }

  myDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Profil ismingizni o'zgartiring"),
              content: Column(
                children: [
                  TextFormField(
                    controller: _disNameController,
                    decoration: InputDecoration(
                        hintText: FirebaseAuthService
                            .auth.currentUser!.displayName
                            .toString(),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  child: const Text("Orqaga"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: const Text("O'zgartirish"),
                  onPressed: () async {
                    await FirebaseAuthService.auth.currentUser!
                        .updateDisplayName(_disNameController.text);
                    setState(() {});
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }
}

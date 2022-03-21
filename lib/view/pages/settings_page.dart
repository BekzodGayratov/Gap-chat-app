import 'package:chatapp/providers/change_disName_provider.dart';
import 'package:chatapp/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => ChangeDisNameProvider(),builder: (context,child){
      return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text("Settings"),
          ),
          body: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.person_outline_rounded),
                title: Text(FirebaseAuthService.auth.currentUser!.displayName.toString()),
                trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text(
                                    "Profil ismingizni o'zgartiring"),
                                content: Column(
                                  children: [
                                    TextFormField(
                                      controller: context.watch<ChangeDisNameProvider>().disNameController,
                                      decoration: InputDecoration(
                                          hintText: FirebaseAuthService
                                              .auth.currentUser!.displayName
                                              .toString(),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0))),
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
                                      await FirebaseAuthService
                                          .auth.currentUser!
                                          .updateDisplayName(
                                              context.watch<ChangeDisNameProvider>().disNameController.text);
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ));
                    }),
              ),
            ],
          ),
        );
    }, );
  }
}

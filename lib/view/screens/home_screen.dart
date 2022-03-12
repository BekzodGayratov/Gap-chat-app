import 'package:animate_do/animate_do.dart';
import 'package:chatapp/core/components/tab_bar_comp.dart';
import 'package:chatapp/services/fireStore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 1;
  CollectionReference privateUsers =
      FirebaseFirestore.instance.collection("users");
  int? length;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.04,
        title: const Text(
          "All users",
        ),
        bottom: TabBar(
          controller: _tabController,
          unselectedLabelColor: Colors.grey,
          tabs: List.generate(tabs.length, (index) {
            return Tab(child: Text(tabs[index]));
          }),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: privateUsers.get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("ERROR"),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (conte, index) {
                        QuerySnapshot<Map<String, dynamic>> data;
                        FireStoreService.fireStore
                            .collection(
                                "users/${snapshot.data!.docs[index].id}/message")
                            .get()
                            .then((value) {
                          data = value;
                        });
                        return FadeInUp(
                          child: InkWell(
                            child: Card(
                              child: InkWell(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        (snapshot.data!.docs[index].data()
                                            as Map)["profilePic"]),
                                    radius: 25.0,
                                  ),
                                  title: Text((snapshot.data!.docs[index].data()
                                          as Map)["displayName"]
                                      .toString()),
                                  subtitle: Text(""),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, '/chatPage',
                                      arguments: [
                                        (snapshot.data!.docs[index].data()
                                                as Map)["displayName"]
                                            .toString(),
                                        snapshot.data!.docs[index].id
                                            .toString(),
                                        (snapshot.data!.docs[index].data()
                                                as Map)["profilePic"]
                                            .toString(),
                                      ]);
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.docs.length),
                )
              ],
            );
          }
        },
      ),
    );
  }
}

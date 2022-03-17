import 'package:chatapp/core/components/tab_bar_comp.dart';
import 'package:chatapp/providers/tab_provider.dart';
import 'package:chatapp/view/pages/all_users.dart';
import 'package:chatapp/view/screens/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<Widget> _pages = [AllUsersScreen(), GroupChat()];
  int? length;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TabProvider(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.04,
            title: const Text(
              "Gap",
            ),
            bottom: TabBar(
              onTap: (v) {
                context.read<TabProvider>().changeIndex(v.toInt());
              },
              controller: _tabController,
              unselectedLabelColor: Colors.grey,
              tabs: List.generate(tabs.length, (index) {
                return Tab(child: Text(tabs[index]));
              }),
            ),
          ),
          body: _pages[context.watch<TabProvider>().currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.black,
            currentIndex: 0,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
            ],
          ),
        );
      },
    );
  }
}

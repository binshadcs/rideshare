import 'package:flutter/material.dart';
import 'package:ridetogether/TabPages/earning.dart';
import 'package:ridetogether/TabPages/home.dart';
import 'package:ridetogether/TabPages/profile.dart';
import 'package:ridetogether/TabPages/rating.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {

  TabController? tabController;
  int selectedIndex = 0;

  onItemClicked(int index){
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }
  @override
  void initState() {
    super.initState();
    
    tabController = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          HomeTab(),
          EarningTab(),
          RatingTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card_outlined),
            label: "Earnings",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.star_half_outlined),
            label: "Ratings",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: "Profile",
          ),


        ],
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellow,
        backgroundColor: Colors.green,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 16),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemClicked,

      ),

    );
  }
}

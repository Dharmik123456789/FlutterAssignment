import 'dart:math';

import 'package:assignment_app/AddMedicineScreen.dart';
import 'package:assignment_app/ProfileScreen.dart';
import 'package:assignment_app/ReportScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();
  int selectedIndex = 0; // 0 = Home, 1 = Report
  bool showNewUI = false;
  final List<MedicineItem> medicines = [
    MedicineItem(
      name: "Calpol 500mg Tablet",
      timing: "Before Breakfast",
      day: "Day 01",
      status: "Taken",
      statusColor: Colors.green,
      icon: Icons.notifications_active,
      iconColor: Colors.green,
      iconBackground: Colors.pink.shade100,
      iconData: Icons.water_drop,
    ),
    MedicineItem(
      name: "Calpol 500mg Tablet",
      timing: "Before Breakfast",
      day: "Day 27",
      status: "Missed",
      statusColor: Colors.red,
      icon: Icons.notifications_off,
      iconColor: Colors.red,
      iconBackground: Colors.blue.shade100,
      iconData: Icons.medical_services,
    ),
  ];

  void changeDate(int days) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: days));
    });
  }

  void showDeviceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            height: 400,
            width: 100,
            child: Column(
              children: [
                 SizedBox(height: 25),
                 Text(
                  "Your Device is not\nconnected",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                 SizedBox(height: 20),
                Image.asset('assets/robot.png', height: 170),
                 SizedBox(height: 30),
                 Text(
                  "Connect your device with",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                 Spacer(),
                ClipRRect(
                  borderRadius:  BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return AddMedicineScreen();
                            },));
                          },
                          child: Container(
                            color: Colors.blue,
                            height: 50,
                            child: Icon(Icons.bluetooth, color: Colors.white, size: 24)
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        width: 1, // Divider line
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.pop(context);
                              showNewUI = true;
                            });
                          },
                          child: Container(
                            color: Colors.blue,
                            height: 50,
                            child: Icon(Icons.wifi, color: Colors.white, size: 24)
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
           SizedBox(height: 60),
          // Header Section
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                      "Hi Harry!",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "5 Medicines Left",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon:  Icon(Icons.medical_services, color: Colors.blue,),
                      onPressed: () {},
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ProfileScreen();
                        },));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                          child: Image.asset("assets/profile_pic.png",height: 40,width: 40,fit: BoxFit.contain,)),
                    )
                  ],
                )
              ],
            ),
          ),

           SizedBox(height: 16),

          // Date Carousel
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon:  Icon(Icons.chevron_left, color: Colors.blue),
                  onPressed: () => changeDate(-1),
                ),
                SizedBox(width: 15,),
                Text(
                  DateFormat('E').format(selectedDate.subtract( Duration(days: 1))),
                  style:  TextStyle(color: Colors.grey, fontSize: 14),
                ),
                SizedBox(width: 20,),
                Container(
                  padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.teal[900],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    DateFormat('EEEE, MMM d').format(selectedDate),
                    style:  TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 20,),
                Text(
                  DateFormat('E').format(selectedDate.add( Duration(days: 1))),
                  style:  TextStyle(color: Colors.grey, fontSize: 14),
                ),
                SizedBox(width: 15,),
                IconButton(
                  icon:  Icon(Icons.chevron_right, color: Colors.blue),
                  onPressed: () => changeDate(1),
                ),
              ],
            ),
          ),

           // Spacer(),

          SizedBox(height: 30,),

          // Page Content (Home/Report)
          selectedIndex == 0
              ? (showNewUI == false ? Center(heightFactor: 3.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(30),child: Image.asset('assets/empty_box.png', height: 150),),
                SizedBox(height: 12),
                Text("Nothing Is Here, Add a Medicine",
                    style: TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
          ) : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Morning Slot
                    Text(
                      "Morning 08:00 am",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 5),
                          itemCount: medicines.length,
                          itemBuilder: (context, index) {
                            return MedicineCard(medicine: medicines[index]);
                          },
                        ),
                      ],
                    ),
                
                    // Afternoon Slot
                    SizedBox(height: 16),
                    Text(
                      "Afternoon 02:00 pm",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 5),
                          itemCount: medicines.length,
                          itemBuilder: (context, index) {
                            return MedicineCard(medicine: medicines[index]);
                          },
                        ),
                      ],
                    ),
                
                    SizedBox(height: 16),
                    Text(
                      "Night 09:00 pm",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 5),
                          itemCount: medicines.length,
                          itemBuilder: (context, index) {
                            return MedicineCard(medicine: medicines[index]);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ))
              :  Container(),

           Spacer(),

          Container(
            height: 70,
            decoration:  BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -1)),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomNavigationBar(
                    currentIndex: selectedIndex,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    selectedItemColor: Colors.blue,
                    unselectedItemColor: Colors.grey,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home, size: 35, color: selectedIndex == 0 ? Colors.blue : Colors.grey),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return ReportScreen();
                            },));
                          },
                            child: Icon(Icons.bar_chart, size: 35, color: selectedIndex == 1 ? Colors.blue : Colors.grey)),
                        label: 'Report',
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -30,
                  left: MediaQuery.of(context).size.width / 2 - 28,
                  child: FloatingActionButton(
                    onPressed: () {
                      showDeviceDialog();
                    },
                    backgroundColor: Colors.black,
                    shape:  CircleBorder(),
                    child:  Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MedicineItem {
  final String name;
  final String timing;
  final String day;
  final String status;
  final Color statusColor;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final IconData iconData;

  MedicineItem({
    required this.name,
    required this.timing,
    required this.day,
    required this.status,
    required this.statusColor,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.iconData,
  });
}

class MedicineCard extends StatelessWidget {
  final MedicineItem medicine;

  const MedicineCard({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: medicine.iconBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(medicine.iconData, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(medicine.name, style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("${medicine.timing}   ${medicine.day}", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(medicine.icon, color: medicine.iconColor),
                const SizedBox(height: 4),
                Text(medicine.status, style: TextStyle(color: medicine.statusColor)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:assignment_app/HomeScreen.dart';
import 'package:flutter/material.dart';

import 'AddMedicineScreen.dart';

class ReportScreen extends StatefulWidget {
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Report",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            _todayReportCard(),
            SizedBox(height: 12),
            _checkDashboardCard(),
            SizedBox(height: 15),
            _checkHistoryRow(),
            SizedBox(height: 15),
            _daySelector(),
            SizedBox(height: 20),
            Expanded(child: _medicineListSection()),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _todayReportCard() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today's Report",style: TextStyle(
            fontSize: 16
          ),),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _reportItem("5", "Total"),
              _reportItem("3", "Taken"),
              _reportItem("1", "Missed"),
              _reportItem("1", "Snoozed"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _reportItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
        Text(label, style: TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }

  Widget _checkDashboardCard() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Check Dashboard", style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Find all active & past medicines", style: TextStyle(color: Colors.grey, fontSize: 16)),
            ],
          ),
          Icon(Icons.pie_chart_outline_rounded, color: Colors.blue, size: 80),
        ],
      ),
    );
  }

  Widget _checkHistoryRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Check History", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
        Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
      ],
    );
  }

  Widget _daySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        bool isSelected = index == 1;
        return Column(
          children: [
            Text(["SUN", "MON", "TUE", "WED", "THU", "FRI","SAT"][index], style: TextStyle(fontSize: 12)),
            SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 45,
                width: 45,
                color: isSelected ? Colors.blue : Colors.grey.shade200,
                child: Center(child: Text("${index + 1}", style: TextStyle(color: isSelected ? Colors.white : Colors.black))),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _medicineListSection() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _timeSlotSection("Morning 08:00 am", [
            _medicineCard("Calpol 500mg Tablet", "Before Breakfast", "Day 01", "Taken"),
            _medicineCard("Calpol 500mg Tablet", "After Food", "Day 01", "Snoozed"),
            _medicineCard("Calpol 500mg Tablet", "Before Breakfast", "Day 27", "Missed"),
          ]),
          SizedBox(height: 10),
          _timeSlotSection("Afternoon 02:00 pm", [
            _medicineCard("Calpol 500mg Tablet", "After Food", "Day 01", "Snoozed"),
            _medicineCard("Calpol 500mg Tablet", "Before Breakfast", "Day 01", "Taken"),
          ]),
        ],
      ),
    );
  }

  Widget _timeSlotSection(String time, List<Widget> medicines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(time, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        ...medicines,
      ],
    );
  }

  Widget _medicineCard(String title, String subtitle, String day, String status) {
    Color statusColor = Colors.green;
    IconData statusIcon = Icons.notifications_active;

    switch (status) {
      case "Missed":
        statusColor = Colors.red;
        statusIcon = Icons.notifications_off;
        break;
      case "Snoozed":
        statusColor = Colors.orange;
        statusIcon = Icons.notifications_none;
        break;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.purple.shade100,
            child: Icon(Icons.local_pharmacy, color: Colors.purple),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                Text("$subtitle   $day", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Column(
            children: [
              Icon(statusIcon, color: statusColor),
              Text(status, style: TextStyle(color: statusColor, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -1))],
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
                BottomNavigationBarItem(icon: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                    child: Icon(Icons.home,size: 35,)), label: 'Home'),
                BottomNavigationBarItem(icon: InkWell(
                  onTap: () {

                  },
                    child: Icon(Icons.bar_chart,size: 35,)), label: 'Report'),
              ],
            ),
          ),
          Positioned(
            top: -30,
            left: MediaQuery.of(context).size.width / 2 - 28,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddMedicineScreen();
                },));
              },
              backgroundColor: Colors.black,
              shape: CircleBorder(),
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

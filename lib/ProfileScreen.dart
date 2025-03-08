import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
              child: Icon(Icons.arrow_back_ios, color: Colors.black)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Info
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                    child: Image.asset("assets/robot.png",height: 70,width: 70,fit: BoxFit.cover,)),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Take Care!", style: TextStyle(color: Colors.grey)),
                    Text("Dharmik Bose", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ],
                )
              ],
            ),
            SizedBox(height: 20),

            Divider(),

            SizedBox(height: 20),

            // Settings Section
            Text("Settings", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            buildSettingItem(Icons.notifications, "Notification", "Check your medicine notification"),
            buildSettingItem(Icons.volume_up, "Sound", "Ring, Silent, Vibrate"),
            buildSettingItem(Icons.person, "Manage Your Account", "Password, Email ID, Phone Number"),
            buildSettingItem(Icons.notifications, "Notification", "Check your medicine notification"),
            buildSettingItem(Icons.notifications, "Notification", "Check your medicine notification"),

            SizedBox(height: 20),

            // Device Section
            Text("Device", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  buildDeviceItem(Icons.wifi, "Connect", "Bluetooth, Wi-Fi"),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: buildDeviceItem(Icons.volume_up, "Sound Option", "Ring, Silent, Vibrate"),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Caretakers Section
            Text("Caretakers: 03", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                spacing: 30,
                children: [
                  buildCaretakerAvatar("Dipa Luna"),
                  buildCaretakerAvatar("Roz Sod.."),
                  buildCaretakerAvatar("Sunny Tu.."),
                  buildAddCaretakerButton(),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Doctor Section
            Text("Doctor", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text("Add Your Doctor", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text.rich(
                    TextSpan(
                      text: "Or use ",
                      children: [
                        TextSpan(
                          text: "invite link",
                          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 20),

            // Other Links
            buildTextLink("Privacy Policy"),
            buildTextLink("Terms of Use"),
            buildTextLink("Rate Us"),
            buildTextLink("Share"),

            SizedBox(height: 20),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade400),
                ),
                child: Text("Log Out", style: TextStyle(color: Colors.black)),
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget buildSettingItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey)),
    );
  }

  Widget buildDeviceItem(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle, style: TextStyle(color: Colors.grey)),
          ],
        )
      ],
    );
  }

  Widget buildCaretakerAvatar(String name) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey.shade300,
            child: Text(name[0], style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 4),
          Text(name, overflow: TextOverflow.ellipsis, maxLines: 1),
        ],
      ),
    );
  }

  Widget buildAddCaretakerButton() {
    return Column(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: Colors.grey.shade300,
          child: Icon(Icons.add),
        ),
        SizedBox(height: 4),
        Text("Add"),
      ],
    );
  }

  Widget buildTextLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(text, style: TextStyle(fontSize: 16)),
    );
  }
}

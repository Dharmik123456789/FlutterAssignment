import 'package:flutter/material.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  int selectedCompartment = 0;
  int selectedColor = 0;
  int quantity = 1;
  int selectedFoodTimingIndex = -1;
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Medicines"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Box
            TextField(
              decoration: InputDecoration(
                hintText: "Search Medicine Name",
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.keyboard_voice),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Compartment
            Text("Compartment"),
            SizedBox(height: 10,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(10, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCompartment = index;
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 50,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: selectedCompartment == index
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1,color: Colors.blue)
                      ),
                      alignment: Alignment.center,
                      child: Text("${index + 1}",style: TextStyle(fontSize: 18),),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 16),

            // Color Selection
            Text("Colour"),
            SizedBox(height: 10,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Colors.pink.shade100,
                  Colors.purple.shade100,
                  Colors.red.shade100,
                  Colors.green.shade100,
                  Colors.orange.shade100,
                  Colors.blue.shade100,
                  Colors.pink.shade100,
                  Colors.purple.shade100,
                  Colors.red.shade100,
                  Colors.green.shade100,
                  Colors.orange.shade100,
                  Colors.blue.shade100
                ].asMap().entries.map((entry) {
                  int index = entry.key;
                  Color color = entry.value;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = index;
                      });
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: selectedColor == index
                            ? Border.all(color: Colors.blue, width: 1)
                            : null,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16),

            // Type
            Text("Type"),
            SizedBox(height: 10,),
            Row(
              children: ["Tablet", "Capsule", "Cream", "Liquid"].asMap().entries.map((type) {
                return Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.circle, color: Colors.pink.shade50,size: 40,),
                      Text(type.value),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16),

            // Quantity
            Text("Quantity"),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Take 1/2 Pill",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                IconButton(
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                ),
                  onPressed: () {
                    setState(() {
                      if (quantity > 1) quantity--;
                    });
                  },
                  icon: Icon(Icons.remove,color: Colors.blue,),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.blue.shade300,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  icon: Icon(Icons.add,color: Colors.white,),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Total Count
            Text("Total Count"),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: quantity.toDouble(),
                    min: 1,
                    max: 100,
                    onChanged: (value) {
                      setState(() {
                        quantity = value.toInt();
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Text(quantity.toString().padLeft(2, '0')),
                )
              ],
            ),
            SizedBox(height: 16),

            // Set Date
            Text("Set Date"),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          startDate = pickedDate;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.blue,width: 1),
                      foregroundColor: Colors.black,
                    ),
                    child: Text(
                      startDate != null
                          ? "${startDate!.day}/${startDate!.month}/${startDate!.year}"
                          : "Today",
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          endDate = pickedDate;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      side: const BorderSide(color: Colors.blue,width: 1),
                      foregroundColor: Colors.black,
                    ),
                    child: Text(
                      endDate != null
                          ? "${endDate!.day}/${endDate!.month}/${endDate!.year}"
                          : "End Date",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Frequency of Days
            Text("Frequency of Days"),
            SizedBox(height: 10,),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(8))
              ),
              value: "Everyday",
              items: ["Everyday", "Alternate Day", "Weekly"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 16),

            // How many times a Day
            Text("How many times a Day"),
            SizedBox(height: 10,),
            DropdownButtonFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8))
              ),
              value: "Three Time",
              items: ["Once", "Twice", "Three Time"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 16),

            // Doses Time
            Column(
              children: [
                buildDoseTile("Dose 1"),
                buildDoseTile("Dose 2"),
                buildDoseTile("Dose 3"),
              ],
            ),
            SizedBox(height: 20),

            // Food Timing
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ["Before Food", "After Food", "Before Sleep"].asMap().entries.map((entry) {
                int index = entry.key;
                String label = entry.value;
                bool isSelected = index == selectedFoodTimingIndex;
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? Colors.blue.shade200 : Colors.blue.shade50,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedFoodTimingIndex = index;
                    });
                  },
                  child: Text(
                    label,
                    style: TextStyle(color: isSelected ? Colors.blue.shade900 : Colors.blue.shade900),
                  ),
                );
              }).toList(),
            ),

            // Add Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade300
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text("Add",style: TextStyle(fontSize: 20,color: Colors.white),),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDoseTile(String doseName) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.access_time),
          title: Text(doseName),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        const Divider(
          height: 0,
        ),
      ],
    );
  }
}

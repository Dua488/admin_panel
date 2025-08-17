import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_route_screen.dart';

class RouteManagementScreen extends StatelessWidget {
  const RouteManagementScreen({super.key});

  static const Color _primaryTextColor = Color(0xFF000000);
  static const Color _secondaryTextColor = Color(0xFF6B7280);
  static const Color _secondaryBackgroundColor = Color(0xFFFFFFFF);
  static const Color _primaryColor = Color(0xFFDFF8C73);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Route Management',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _primaryTextColor),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddRouteScreen()),
                  );
                },
                icon: const Icon(Icons.add_road, color: _secondaryBackgroundColor),
                label: const Text("Add New Route", style: TextStyle(color: _secondaryBackgroundColor)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Fetch data from Firestore
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("routes").orderBy("createdAt", descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No routes available"));
                }

                final routes = snapshot.data!.docs;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 30,
                    horizontalMargin: 10,
                    columns: const [
                      DataColumn(label: Text("Route Name")),
                      DataColumn(label: Text("Start")),
                      DataColumn(label: Text("End")),
                      DataColumn(label: Text("Bus")),
                      DataColumn(label: Text("Driver")),
                      DataColumn(label: Text("Status")),
                      DataColumn(label: Text("Time")),
                    ],
                    rows: routes.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return DataRow(
                        cells: [
                          DataCell(Text(data['routeName'] ?? "")),
                          DataCell(Text(data['startLocation'] ?? "")),
                          DataCell(Text(data['endLocation'] ?? "")),
                          DataCell(Text(data['assignedBus'] ?? "")),
                          DataCell(Text(data['assignedDriver'] ?? "")),
                          DataCell(Text(data['status'] ?? "")),
                          DataCell(Text(data['time'] ?? "")),
                        ],
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

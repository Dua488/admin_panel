// route view
import 'package:flutter/material.dart';
import 'package:admin_panel/screens/route_management/widgets/route_list_item.dart'; // Import the AddRouteScreen

class RouteManagementScreen extends StatelessWidget {
  const RouteManagementScreen({super.key});

  // Mock route data for demonstration purposes
  final List<Map<String, dynamic>> _routeData = const [
    {
      'id': 'R001',
      'routeName': 'Downtown Express',
      'startLocation': 'City Center',
      'endLocation': 'Business Park',
      'assignedBus': 'Bus 101',
      'assignedDriver': 'John Doe',
      'status': 'In Progress',
      'startTime': '08:00 AM',
      'lastUpdate': '08:45 AM',
    },
    {
      'id': 'R002',
      'routeName': 'Suburb Shuttle',
      'startLocation': 'Residential Area',
      'endLocation': 'Shopping Mall',
      'assignedBus': 'Bus 102',
      'assignedDriver': 'Jane Smith',
      'status': 'Completed',
      'startTime': '09:00 AM',
      'endTime': '10:30 AM',
    },
    {
      'id': 'R003',
      'routeName': 'University Link',
      'startLocation': 'Main Campus',
      'endLocation': 'Student Dorms',
      'assignedBus': 'Bus 103',
      'assignedDriver': 'Mike Johnson',
      'status': 'Scheduled',
      'scheduledTime': '11:00 AM',
    },
    {
      'id': 'R004',
      'routeName': 'Airport Connect',
      'startLocation': 'Central Station',
      'endLocation': 'Airport Terminal',
      'assignedBus': 'Bus 104',
      'assignedDriver': 'Sarah Williams',
      'status': 'Delayed',
      'expectedTime': '01:30 PM',
    },
  ];

  // Colors from the provided image
  static const Color _primaryTextColor = Color(0xFF000000);
  static const Color _secondaryTextColor = Color(0xFF6B7280);
  static const Color _primaryBackgroundColor = Color(0xFFF1F4F8);
  static const Color _secondaryBackgroundColor = Color(0xFFFFFFFF);
  static const Color _primaryColor = Color(0xFFDFF8C73); // Primary Brand Color

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Route Management',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: _primaryTextColor,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to the AddRouteScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddRouteScreen()),
                  );
                },
                icon: const Icon(Icons.add_road, color: _secondaryBackgroundColor),
                label: const Text(
                  'Add New Route',
                  style: TextStyle(color: _secondaryBackgroundColor),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor, // Use primary brand color
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: _secondaryBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) => _primaryColor.withOpacity(0.1),
                  ),
                  dataRowColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) => _secondaryBackgroundColor,
                  ),
                  columnSpacing: 30,
                  horizontalMargin: 10,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  columns: const [
                    DataColumn(
                      label: Text(
                        'ID',
                        style: TextStyle(fontWeight: FontWeight.bold, color: _primaryTextColor),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Route Name',
                        style: TextStyle(fontWeight: FontWeight.bold, color: _primaryTextColor),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Start',
                        style: TextStyle(fontWeight: FontWeight.bold, color: _primaryTextColor),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'End',
                        style: TextStyle(fontWeight: FontWeight.bold, color: _primaryTextColor),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Bus',
                        style: TextStyle(fontWeight: FontWeight.bold, color: _primaryTextColor),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Driver',
                        style: TextStyle(fontWeight: FontWeight.bold, color: _primaryTextColor),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Status',
                        style: TextStyle(fontWeight: FontWeight.bold, color: _primaryTextColor),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Time Info',
                        style: TextStyle(fontWeight: FontWeight.bold, color: _primaryTextColor),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Actions',
                        style: TextStyle(fontWeight: FontWeight.bold, color: _primaryTextColor),
                      ),
                    ),
                  ],
                  rows: _routeData.map((route) {
                    return DataRow(
                      cells: [
                        DataCell(Text(route['id']!, style: const TextStyle(color: _secondaryTextColor))),
                        DataCell(Text(route['routeName']!, style: const TextStyle(color: _primaryTextColor))),
                        DataCell(Text(route['startLocation']!, style: const TextStyle(color: _secondaryTextColor))),
                        DataCell(Text(route['endLocation']!, style: const TextStyle(color: _secondaryTextColor))),
                        DataCell(Text(route['assignedBus']!, style: const TextStyle(color: _primaryTextColor))),
                        DataCell(Text(route['assignedDriver']!, style: const TextStyle(color: _primaryTextColor))),
                        DataCell(
                          Chip(
                            label: Text(route['status']!),
                            backgroundColor: route['status'] == 'In Progress'
                                ? Colors.blue.shade100
                                : route['status'] == 'Completed'
                                ? Colors.green.shade100
                                : route['status'] == 'Scheduled'
                                ? Colors.grey.shade300
                                : Colors.red.shade100, // Delayed
                            labelStyle: TextStyle(
                              color: route['status'] == 'In Progress'
                                  ? Colors.blue.shade800
                                  : route['status'] == 'Completed'
                                  ? Colors.green.shade800
                                  : route['status'] == 'Scheduled'
                                  ? Colors.grey.shade800
                                  : Colors.red.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            route['startTime'] != null
                                ? 'Start: ${route['startTime']}'
                                : route['scheduledTime'] != null
                                ? 'Scheduled: ${route['scheduledTime']}'
                                : route['expectedTime'] != null
                                ? 'Expected: ${route['expectedTime']}'
                                : '',
                            style: const TextStyle(color: _secondaryTextColor),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: _primaryColor),
                                tooltip: 'Edit Route',
                                onPressed: () {
                                  // Implement edit functionality
                                  print('Edit route: ${route['routeName']}');
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                tooltip: 'Delete Route',
                                onPressed: () {
                                  // Implement delete functionality
                                  print('Delete route: ${route['routeName']}');
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// view driver
import 'package:flutter/material.dart';
import 'package:admin_panel/screens/driver_registration/widgets/driver_form.dart'; // Import the AddDriverScreen
import 'package:admin_panel/screens/driver_registration/widgets/add_vehicle.dart'; // Import the new dialog

class DriverRegistrationScreen extends StatelessWidget {
  const DriverRegistrationScreen({super.key});

  // Mock driver data for demonstration purposes
  final List<Map<String, dynamic>> _driverData = const [
    {
      'id': 'DRV001',
      'name': 'John Doe',
      'contact': '555-1111',
      'license': 'DL12345',
      'assignedVehicle': 'Bus 101',
      'status': 'Active',
    },
    {
      'id': 'DRV002',
      'name': 'Jane Smith',
      'contact': '555-2222',
      'license': 'DL67890',
      'assignedVehicle': 'Bus 102',
      'status': 'Active',
    },
    {
      'id': 'DRV003',
      'name': 'Mike Johnson',
      'contact': '555-3333',
      'license': 'DL24680',
      'assignedVehicle': 'Bus 103',
      'status': 'On Leave',
    },
    {
      'id': 'DRV004',
      'name': 'Sarah Williams',
      'contact': '555-4444',
      'license': 'DL13579',
      'assignedVehicle': 'Bus 104',
      'status': 'Active',
    },
  ];

  // Colors from the provided image
  static const Color _primaryTextColor = Color(0xFF000000);
  static const Color _secondaryTextColor = Color(0xFF6B7280);
  static const Color _primaryBackgroundColor = Color(0xFFF1F4F8);
  static const Color _secondaryBackgroundColor = Color(0xFFFFFFFF);
  static const Color _primaryColor = Color(0xFFDFF8C73); // Primary Brand Color
  static const Color _secondaryColor = Color(0xFFFEB269); // Secondary Brand Color for the new button

  // Method to show the Add Vehicle dialog
  void _showAddVehicleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddVehicleDialog();
      },
    );
  }

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
                'Driver Registration & Management',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: _primaryTextColor,
                ),
              ),
              Row(
                children: [
                  // New "Add Vehicle" button
                  ElevatedButton.icon(
                    onPressed: () => _showAddVehicleDialog(context),
                    icon: const Icon(Icons.add_road, color: _secondaryBackgroundColor),
                    label: const Text(
                      'Add Vehicle',
                      style: TextStyle(color: _secondaryBackgroundColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _secondaryColor, // Using a different color for distinction
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                    ),
                  ),
                  const SizedBox(width: 15),
                  // Existing "Register New Driver" button
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to the AddDriverScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddDriverScreen()),
                      );
                    },
                    icon: const Icon(Icons.person_add, color: _secondaryBackgroundColor),
                    label: const Text(
                      'Register New Driver',
                      style: TextStyle(color: _secondaryBackgroundColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                    ),
                  ),
                ],
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
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.bold, color: _primaryTextColor),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Contact',
                        style: TextStyle(fontWeight: FontWeight.bold, color: _primaryTextColor),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'License',
                        style: TextStyle(fontWeight: FontWeight.bold, color: _primaryTextColor),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Assigned Vehicle',
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
                        'Actions',
                        style: TextStyle(fontWeight: FontWeight.bold, color: _primaryTextColor),
                      ),
                    ),
                  ],
                  rows: _driverData.map((driver) {
                    return DataRow(
                      cells: [
                        DataCell(Text(driver['id']!, style: const TextStyle(color: _secondaryTextColor))),
                        DataCell(Text(driver['name']!, style: const TextStyle(color: _primaryTextColor))),
                        DataCell(Text(driver['contact']!, style: const TextStyle(color: _secondaryTextColor))),
                        DataCell(Text(driver['license']!, style: const TextStyle(color: _primaryTextColor))),
                        DataCell(Text(driver['assignedVehicle']!, style: const TextStyle(color: _primaryTextColor))),
                        DataCell(
                          Chip(
                            label: Text(driver['status']!),
                            backgroundColor: driver['status'] == 'Active'
                                ? Colors.green.shade100
                                : driver['status'] == 'On Leave'
                                ? Colors.orange.shade100
                                : Colors.red.shade100, // Fallback for other statuses
                            labelStyle: TextStyle(
                              color: driver['status'] == 'Active'
                                  ? Colors.green.shade800
                                  : driver['status'] == 'On Leave'
                                  ? Colors.orange.shade800
                                  : Colors.red.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: _primaryColor),
                                tooltip: 'Edit Driver',
                                onPressed: () {
                                  // Implement edit functionality
                                  print('Edit driver: ${driver['name']}');
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                tooltip: 'Delete Driver',
                                onPressed: () {
                                  // Implement delete functionality
                                  print('Delete driver: ${driver['name']}');
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

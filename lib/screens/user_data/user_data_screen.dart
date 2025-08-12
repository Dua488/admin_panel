import 'package:flutter/material.dart';

class UserDataScreen extends StatelessWidget {
  const UserDataScreen({super.key});

  // Mock user data for demonstration purposes
  // In a real application, this data would be fetched from Firebase Firestore
  final List<Map<String, dynamic>> _userData = const [
    {
      'id': 'user_001',
      'name': 'Alice Smith',
      'address': '123 Main St, Anytown',
      'contact': '555-1234',
      'email': 'alice.s@example.com',
      'status': 'Active',
    },
    {
      'id': 'user_002',
      'name': 'Bob Johnson',
      'address': '456 Oak Ave, Otherville',
      'contact': '555-5678',
      'email': 'bob.j@example.com',
      'status': 'Inactive',
    },
    {
      'id': 'user_003',
      'name': 'Charlie Brown',
      'address': '789 Pine Ln, Somewhere',
      'contact': '555-9012',
      'email': 'charlie.b@example.com',
      'status': 'Active',
    },
    {
      'id': 'user_004',
      'name': 'Diana Prince',
      'address': '101 Hero Rd, Themyscira',
      'contact': '555-3456',
      'email': 'diana.p@example.com',
      'status': 'Active',
    },
    {
      'id': 'user_005',
      'name': 'Eve Adams',
      'address': '202 Apple Blvd, Eden',
      'contact': '555-7890',
      'email': 'eve.a@example.com',
      'status': 'Pending',
    },
  ];

  // Colors from the provided image (re-defined for self-containment, but ideally from a theme)
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
          Text(
            'User Data Overview',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: _primaryTextColor,
            ),
          ),
          const SizedBox(height: 20),
          // A Card to give the table a nice elevated look
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: _secondaryBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Allows horizontal scrolling for wide tables
                child: DataTable(
                  headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) => _primaryColor.withOpacity(0.1), // Light primary color for header
                  ),
                  dataRowColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) => _secondaryBackgroundColor, // White for data rows
                  ),
                  columnSpacing: 30, // Space between columns
                  horizontalMargin: 10, // Horizontal margin for the table
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300), // Light border around the table
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
                        'Address',
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
                        'Email',
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
                  rows: _userData.map((user) {
                    return DataRow(
                      cells: [
                        DataCell(Text(user['id']!, style: const TextStyle(color: _secondaryTextColor))),
                        DataCell(Text(user['name']!, style: const TextStyle(color: _primaryTextColor))),
                        DataCell(Text(user['address']!, style: const TextStyle(color: _secondaryTextColor))),
                        DataCell(Text(user['contact']!, style: const TextStyle(color: _primaryTextColor))),
                        DataCell(Text(user['email']!, style: const TextStyle(color: _secondaryTextColor))),
                        DataCell(
                          Chip(
                            label: Text(user['status']!),
                            backgroundColor: user['status'] == 'Active'
                                ? Colors.green.shade100
                                : user['status'] == 'Inactive'
                                ? Colors.red.shade100
                                : Colors.orange.shade100,
                            labelStyle: TextStyle(
                              color: user['status'] == 'Active'
                                  ? Colors.green.shade800
                                  : user['status'] == 'Inactive'
                                  ? Colors.red.shade800
                                  : Colors.orange.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: _primaryColor),
                                tooltip: 'Edit User',
                                onPressed: () {
                                  // Implement edit functionality
                                  print('Edit user: ${user['name']}');
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                tooltip: 'Delete User',
                                onPressed: () {
                                  // Implement delete functionality
                                  print('Delete user: ${user['name']}');
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

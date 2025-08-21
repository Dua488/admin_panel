import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
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
          // StreamBuilder to listen for real-time updates from Firestore
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'No user data found.',
                      style: TextStyle(fontSize: 18, color: _secondaryTextColor),
                    ),
                  );
                }

                final List<DocumentSnapshot> documents = snapshot.data!.docs;

                return Card(
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
                              'CMS ID',
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
                              'Home Address',
                              style: TextStyle(fontWeight: FontWeight.bold, color: _primaryTextColor),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Email',
                              style: TextStyle(fontWeight: FontWeight.bold, color: _primaryTextColor),
                            ),
                          ),
                        ],
                        rows: documents.map((doc) {
                          final user = doc.data() as Map<String, dynamic>;
                          return DataRow(
                            cells: [
                              DataCell(Text(user['cmsId'] ?? 'N/A', style: const TextStyle(color: _primaryTextColor))),
                              DataCell(Text(user['name'] ?? 'N/A', style: const TextStyle(color: _primaryTextColor))),
                              DataCell(Text(user['homeAddress'] ?? 'N/A', style: const TextStyle(color: _secondaryTextColor))),
                              DataCell(Text(user['email'] ?? 'N/A', style: const TextStyle(color: _secondaryTextColor))),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
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
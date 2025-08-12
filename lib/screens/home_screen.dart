import 'package:flutter/material.dart';

// Import screens from their respective files
import 'user_data/user_data_screen.dart';
import 'notifications/notifications_screen.dart';
import 'driver_registration/driver_registration_screen.dart';
import 'route_management/route_management_screen.dart';
import 'reports/reports_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // To keep track of the selected tab

  // List of screens corresponding to each tab
  final List<Widget> _screens = [
    const UserDataScreen(),
    const NotificationsScreen(),
    const DriverRegistrationScreen(),
    const RouteManagementScreen(),
   // const ReportsScreen(),
  ];

  // Colors from the provided image
  static const Color _primaryColor = Color(0xFFDFF8C73);
  static const Color _secondaryColor = Color(0xFFFEB269);
  static const Color _tertiaryColor = Color(0xFFDCFCE7);
  static const Color _alternateColor = Color(0xFFFEF9C3);
  static const Color _primaryTextColor = Color(0xFF000000);
  static const Color _secondaryTextColor = Color(0xFF6B7280);
  static const Color _primaryBackgroundColor = Color(0xFFF1F4F8);
  static const Color _secondaryBackgroundColor = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Busmate Admin Panel',
          style: TextStyle(color: _primaryTextColor),
        ),
        backgroundColor: _primaryBackgroundColor,
        elevation: 0, // Remove shadow
      ),
      body: Row(
        children: [
          // Left side: Navigation Tabs (20% width)
          Container(
            width: MediaQuery.of(context).size.width * 0.2, // 20% of screen width
            color: _primaryBackgroundColor,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              children: [
                _buildDrawerItem(
                  icon: Icons.people,
                  title: 'User Data View',
                  index: 0,
                ),
                _buildDrawerItem(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  index: 1,
                ),
                _buildDrawerItem(
                  icon: Icons.person_add,
                  title: 'Driver Registration',
                  index: 2,
                ),
                _buildDrawerItem(
                  icon: Icons.alt_route,
                  title: 'Route Management',
                  index: 3,
                ),
                _buildDrawerItem(
                  icon: Icons.bar_chart,
                  title: 'Reports',
                  index: 4,
                ),
              ],
            ),
          ),
          // Right side: Tab Screens (80% width)
          Expanded(
            child: Container(
              color: _secondaryBackgroundColor,
              child: _screens[_selectedIndex], // Display the selected screen
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build each drawer item (tab)
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final bool isSelected = _selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Material(
        color: isSelected ? _secondaryColor.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
          },
          borderRadius: BorderRadius.circular(10.0),
          hoverColor: _secondaryColor.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected ? _primaryColor : _secondaryTextColor,
                  size: 24,
                ),
                const SizedBox(width: 15),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? _primaryColor : _primaryTextColor,
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

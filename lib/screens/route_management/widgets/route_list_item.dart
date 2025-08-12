// add route
import 'package:flutter/material.dart';

class AddRouteScreen extends StatefulWidget {
  const AddRouteScreen({super.key});

  @override
  State<AddRouteScreen> createState() => _AddRouteScreenState();
}

class _AddRouteScreenState extends State<AddRouteScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _routeNameController = TextEditingController();
  final TextEditingController _startLocationController = TextEditingController();
  final TextEditingController _endLocationController = TextEditingController();
  final TextEditingController _assignedBusController = TextEditingController();
  final TextEditingController _assignedDriverController = TextEditingController();

  // Colors from the provided image
  static const Color _primaryTextColor = Color(0xFF000000);
  static const Color _secondaryTextColor = Color(0xFF6B7280);
  static const Color _primaryBackgroundColor = Color(0xFFF1F4F8);
  static const Color _secondaryBackgroundColor = Color(0xFFFFFFFF);
  static const Color _primaryColor = Color(0xFFDFF8C73); // Primary Brand Color

  @override
  void dispose() {
    _routeNameController.dispose();
    _startLocationController.dispose();
    _endLocationController.dispose();
    _assignedBusController.dispose();
    _assignedDriverController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process data
      final routeData = {
        'routeName': _routeNameController.text,
        'startLocation': _startLocationController.text,
        'endLocation': _endLocationController.text,
        'assignedBus': _assignedBusController.text,
        'assignedDriver': _assignedDriverController.text,
      };
      print('New Route Data: $routeData');
      // Here you would typically send this data to Firebase Firestore
      // After successful submission, you might want to navigate back
      Navigator.pop(context);
      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Route "${_routeNameController.text}" added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Route',
          style: TextStyle(color: _primaryTextColor),
        ),
        backgroundColor: _primaryBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _primaryTextColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: _secondaryBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Enter Route Details',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _primaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _routeNameController,
                      labelText: 'Route Name (e.g., Downtown Express)',
                      icon: Icons.alt_route,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter route name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _startLocationController,
                      labelText: 'Start Location',
                      icon: Icons.location_on,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter start location';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _endLocationController,
                      labelText: 'End Location',
                      icon: Icons.location_on_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter end location';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _assignedBusController,
                      labelText: 'Assigned Bus (e.g., Bus 105)',
                      icon: Icons.bus_alert,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please assign a bus';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _assignedDriverController,
                      labelText: 'Assigned Driver (e.g., John Doe)',
                      icon: Icons.person,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please assign a driver';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      onPressed: _submitForm,
                      icon: const Icon(Icons.add_road, color: _secondaryBackgroundColor),
                      label: const Text(
                        'Add Route',
                        style: TextStyle(fontSize: 18, color: _secondaryBackgroundColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryColor, // Use primary brand color
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: _primaryTextColor),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: _secondaryTextColor),
        prefixIcon: Icon(icon, color: _primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _secondaryTextColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _primaryColor, width: 2),
        ),
        filled: true,
        fillColor: _primaryBackgroundColor,
      ),
      validator: validator,
    );
  }
}

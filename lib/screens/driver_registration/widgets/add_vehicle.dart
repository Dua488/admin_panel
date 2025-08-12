import 'package:flutter/material.dart';

class AddVehicleDialog extends StatefulWidget {
  const AddVehicleDialog({super.key});

  @override
  State<AddVehicleDialog> createState() => _AddVehicleDialogState();
}

class _AddVehicleDialogState extends State<AddVehicleDialog> {
  final TextEditingController _vehicleController = TextEditingController();
  final List<String> _newVehicles = [];

  // Colors from the provided image
  static const Color _primaryTextColor = Color(0xFF000000);
  static const Color _secondaryTextColor = Color(0xFF6B7280);
  static const Color _primaryBackgroundColor = Color(0xFFF1F4F8);
  static const Color _secondaryBackgroundColor = Color(0xFFFFFFFF);
  static const Color _primaryColor = Color(0xFFDFF8C73); // Primary Brand Color
  static const Color _chipBackground = Color(0xFFFEF9C3);
  static const Color _chipText = Color(0xFFF9E073);


  @override
  void dispose() {
    _vehicleController.dispose();
    super.dispose();
  }

  void _addVehicles() {
    final String vehiclesInput = _vehicleController.text.trim();
    if (vehiclesInput.isNotEmpty) {
      setState(() {
        _newVehicles.add(vehiclesInput);
      });
      _vehicleController.clear();
    }

    if (_newVehicles.isNotEmpty) {
      print('New vehicles to add: $_newVehicles');
      // Here you would typically add these new vehicles to your database

      Navigator.pop(context); // Close the dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vehicles added successfully: ${_newVehicles.join(', ')}'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      Navigator.pop(context); // Close the dialog
    }
  }

  void _addChipFromInput() {
    final text = _vehicleController.text.trim();
    if (text.endsWith(',')) {
      final chipText = text.substring(0, text.length - 1).trim();
      if (chipText.isNotEmpty) {
        setState(() {
          _newVehicles.add(chipText);
          _vehicleController.clear();
        });
      }
    }
  }

  void _removeChip(String vehicle) {
    setState(() {
      _newVehicles.remove(vehicle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 450, // Set a fixed width for the dialog as in the image
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: _secondaryBackgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Manage Vehicles',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: _primaryTextColor,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: _secondaryTextColor),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Divider(color: Colors.grey.shade300, height: 1),
            const SizedBox(height: 20.0),
            Text(
              'Add new vehicles (comma separated)',
              style: TextStyle(
                fontSize: 14.0,
                color: _secondaryTextColor,
              ),
            ),
            const SizedBox(height: 10.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _newVehicles.map((vehicle) {
                return Chip(
                  label: Text(vehicle),
                  labelStyle: const TextStyle(color: _primaryTextColor, fontWeight: FontWeight.bold),
                  backgroundColor: _chipBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none,
                  ),
                  deleteIcon: const Icon(Icons.close, size: 18, color: _primaryTextColor),
                  onDeleted: () => _removeChip(vehicle),
                );
              }).toList(),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _vehicleController,
              keyboardType: TextInputType.text,
              style: const TextStyle(color: _primaryTextColor),
              onChanged: (text) => _addChipFromInput(),
              decoration: InputDecoration(
                hintText: 'e.g., Bus 101, Bus 102',
                hintStyle: TextStyle(color: _secondaryTextColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: _secondaryTextColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: _primaryColor, width: 2),
                ),
                filled: true,
                fillColor: _primaryBackgroundColor,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _addVehicles,
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Add Vehicles',
                style: TextStyle(fontSize: 16, color: _secondaryBackgroundColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

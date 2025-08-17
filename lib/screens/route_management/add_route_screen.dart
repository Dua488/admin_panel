import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddRouteScreen extends StatefulWidget {
  const AddRouteScreen({super.key});

  @override
  State<AddRouteScreen> createState() => _AddRouteScreenState();
}

class _AddRouteScreenState extends State<AddRouteScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController routeNameController = TextEditingController();
  final TextEditingController startLocationController = TextEditingController();
  final TextEditingController endLocationController = TextEditingController();
  final TextEditingController busController = TextEditingController();
  final TextEditingController driverController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  String status = "Scheduled";

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection("routes").add({
          "routeName": routeNameController.text,
          "startLocation": startLocationController.text,
          "endLocation": endLocationController.text,
          "assignedBus": busController.text,
          "assignedDriver": driverController.text,
          "status": status,
          "time": timeController.text,
          "createdAt": FieldValue.serverTimestamp(),
        });

        Navigator.pop(context); // Go back to RouteManagementScreen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Route added successfully")),
        );
      } catch (e) {
        print("Error saving route: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Route")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: routeNameController,
                decoration: const InputDecoration(labelText: "Route Name"),
                validator: (value) => value!.isEmpty ? "Enter route name" : null,
              ),
              TextFormField(
                controller: startLocationController,
                decoration: const InputDecoration(labelText: "Start Location"),
                validator: (value) => value!.isEmpty ? "Enter start location" : null,
              ),
              TextFormField(
                controller: endLocationController,
                decoration: const InputDecoration(labelText: "End Location"),
                validator: (value) => value!.isEmpty ? "Enter end location" : null,
              ),
              TextFormField(
                controller: busController,
                decoration: const InputDecoration(labelText: "Bus"),
              ),
              TextFormField(
                controller: driverController,
                decoration: const InputDecoration(labelText: "Driver"),
              ),
              DropdownButtonFormField<String>(
                value: status,
                items: ["Scheduled", "In Progress", "Completed", "Delayed"]
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => setState(() => status = val!),
                decoration: const InputDecoration(labelText: "Status"),
              ),
              TextFormField(
                controller: timeController,
                decoration: const InputDecoration(labelText: "Time Info"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

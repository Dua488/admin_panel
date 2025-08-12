//notification screen
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // State variables for the form
  String? _recipientType;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  // Colors from the provided image
  static const Color _primaryTextColor = Color(0xFF000000);
  static const Color _secondaryTextColor = Color(0xFF6B7280);
  static const Color _primaryBackgroundColor = Color(0xFFF1F4F8);
  static const Color _secondaryBackgroundColor = Color(0xFFFFFFFF);
  static const Color _primaryColor = Color(0xFFDFF8C73); // Primary Brand Color

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _sendNotification() {
    final String title = _titleController.text.trim();
    final String body = _bodyController.text.trim();

    if (_recipientType == null || title.isEmpty || body.isEmpty) {
      // Show an error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all the fields to send a notification.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Print the notification data to the console for demonstration
    print('Sending notification to: $_recipientType');
    print('Title: $title');
    print('Body: $body');

    // Here you would typically call a service to send the notification
    // e.g., using a Firebase Cloud Messaging service or a backend API.

    // Show success message and clear the form
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notification sent to $_recipientType successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    _titleController.clear();
    _bodyController.clear();
    setState(() {
      _recipientType = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send Notifications',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: _primaryTextColor,
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: _secondaryBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recipient',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _primaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _recipientType,
                    onChanged: (String? newValue) {
                      setState(() {
                        _recipientType = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Select recipient type',
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
                    items: const [
                      DropdownMenuItem(
                        value: 'Users',
                        child: Text('Users', style: TextStyle(color: _primaryTextColor)),
                      ),
                      DropdownMenuItem(
                        value: 'Drivers',
                        child: Text('Drivers', style: TextStyle(color: _primaryTextColor)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Notification Title',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _primaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Enter notification title',
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
                    style: const TextStyle(color: _primaryTextColor),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Notification Body',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _primaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _bodyController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Enter notification body',
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
                    style: const TextStyle(color: _primaryTextColor),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _sendNotification,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                    ),
                    child: const Text(
                      'Send Notification',
                      style: TextStyle(fontSize: 16, color: _secondaryBackgroundColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

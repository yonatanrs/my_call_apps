import 'package:flutter/material.dart';
import 'package:call_apps/models/lead_model.dart';

class IncomingCallPage extends StatelessWidget {
  final LeadModel lead;

  IncomingCallPage({required this.lead});

  String _getInitials(String name) {
    List<String> nameParts = name.split(' ');
    return nameParts.length > 1
        ? nameParts.first[0] + nameParts.last[0]
        : nameParts.first[0];
  }

  @override
  Widget build(BuildContext context) {
    String initials = _getInitials(lead.name); // Get initials from the lead name
    String phoneNumber = lead.phoneNumber ?? '+91 0645423781'; // Default phone number if null

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 48), // Optional: Adjust space from the top if necessary
            Text(
              'Incoming Call',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal, color: Colors.grey,
              ),
            ),
            SizedBox(height: 16), // Reduced space
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.purpleAccent.withOpacity(0.3),
              child: Text(
                initials, // Use dynamic initials
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.purple,
                ),
              ),
            ),
            SizedBox(height: 16), // Reduced space
            Text(
              lead.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8), // Reduced space
            Text(
              phoneNumber, // Use dynamic phone number
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 255), // Space before buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      onPressed: () {

                      },
                      backgroundColor: Colors.green,
                      child: Icon(Icons.call),
                      shape: CircleBorder(),
                    ),
                    SizedBox(height: 8),
                    Text('Lift', style: TextStyle(color: Colors.grey)), // Label under the button
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      backgroundColor: Colors.red,
                      child: Icon(Icons.call_end),
                      shape: CircleBorder(),
                    ),
                    SizedBox(height: 8),
                    Text('Hangover', style: TextStyle(color: Colors.grey),), // Label under the button
                  ],
                ),
              ],
            ),
            SizedBox(height: 48), // Optional: Adjust space from the bottom if necessary
          ],
        ),
      ),
    );
  }
}

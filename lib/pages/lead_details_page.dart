import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:call_apps/models/lead_model.dart';
import 'package:intl/intl.dart';

class LeadDetailsPage extends StatelessWidget {
  final LeadModel lead;

  LeadDetailsPage({required this.lead});

  @override
  Widget build(BuildContext context) {
    // Prepare the data for the QR Code
    final qrData = 'Name: ${lead.name}, Phone: ${lead.phoneNumber}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Lead Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // This will center the title in the AppBar
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Actions go here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name, Distance, and Status in a row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          lead.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8), // Adjust the space as needed
                      Text(
                        "${lead.distance ?? ''} km away",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Ready to join label
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color of the container
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Colors.green, // Color of the border
                      width: 1, // Width of the border
                    ),
                  ),
                  child: Text(
                    'Ready to join',
                    style: TextStyle(fontSize: 12, color: Colors.green), // Text color
                  ),
                ),

              ],
            ),
            SizedBox(height: 16),
            // Class, Subjects, Budget and Demo Date
            Text(
              '${lead.grade}',
              style: TextStyle(fontSize: 18, color:  Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              lead.subjects != null ? lead.subjects!.join(', ') : 'No Subjects',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text('Demo date: ${lead.demoDate != null ? DateFormat('dd MMM').format(lead.demoDate!) : 'Not set'}'),
            SizedBox(height: 24),
            // QR Code Section
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 16, bottom: 32),
              child: Column(
                children: [
                  Text(
                    'Receive payment of ₹${lead.budget}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: qrData,
                    width: 200,
                    height: 200,
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                'or',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
            SizedBox(height: 16),
            // Send Payment Link Button
            ElevatedButton(
              onPressed: () {
                // Handle sending payment link
              },
              child: Text('Send Payment Link To ${lead.name}'),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                minimumSize: Size(double.infinity, 50), // Adjust size to match your UI design
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                'or',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
            SizedBox(height: 16),
            // Cash Collected Button
            ElevatedButton(
              onPressed: () {
                // Handle cash collected
              },
              child: Text(
                'Cash collected',
                style: TextStyle(color: Colors.purple),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                  side: BorderSide(color: Colors.purple),
                ),
                minimumSize: Size(double.infinity, 50), // Adjust size to match your UI design
              ),
            ),
          ],
        ),
      ),
    );
  }
}

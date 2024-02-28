import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:call_apps/models/lead_model.dart'; // Replace with your actual package name
import 'package:call_apps/pages/lead_details_page.dart'; // Replace with your actual package name

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  CustomBottomNavBar({Key? key, this.currentIndex = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Leads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 1) { // Assuming Leads is at index 1
            // Create an instance of LeadModel with all required fields
            var leadDetail = LeadModel(
              id: '1',
              name: 'Rajbir',
              interactionType: 'chat',
              lastInteractionTime: DateTime.now(),
              phoneNumber: '1234567890',
              isMissed: false,
              grade: '7th class',
              subjects: ['English', 'Maths', 'Science'],
              demoDate: DateTime(2022, 2, 7),
              budget: 1500,
              payment: 1500,
              qrCodeUrl: 'https://example.com/qr-code',
            );
            // Navigate to LeadDetailsPage using Get.to and passing the leadDetail
            Get.to(() => LeadDetailsPage(lead: leadDetail));
          }
          // Handle other navigation if necessary
        },
      ),
    );
  }
}

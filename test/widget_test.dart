import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:call_apps/pages/lead_management_page.dart';
import 'package:call_apps/controllers/lead_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // Initialize your controllers here. This is crucial for making sure they are available throughout the app.
  final LeadController leadController = Get.put(LeadController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LeadManagementPage(), // The initial page of your application
      getPages: [ // Define routes for navigation
        GetPage(name: '/leadManagement', page: () => LeadManagementPage()),
        // Add routes for other pages
      ],
    );
  }
}

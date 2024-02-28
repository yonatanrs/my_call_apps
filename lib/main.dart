import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:call_apps/pages/lead_management_page.dart';
import 'package:call_apps/controllers/lead_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(LeadController()); // Initialize controller
    return GetMaterialApp(
      home: LeadManagementPage(),
    );
  }
}

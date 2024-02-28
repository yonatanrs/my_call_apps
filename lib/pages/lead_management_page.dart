import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:call_apps/controllers/lead_controller.dart';
import 'package:call_apps/widgets/lead_item_widget.dart';
import 'package:call_apps/widgets/custom_appbar.dart';
import 'package:call_apps/widgets/custom_bottom_navbar.dart';
import 'package:call_apps/widgets/tab_button.dart';
import 'package:call_apps/pages/list_chat_call_page.dart';
import 'package:call_apps/models/lead_model.dart';

class LeadManagementPage extends StatefulWidget {
  @override
  _LeadManagementPageState createState() => _LeadManagementPageState();
}

class _LeadManagementPageState extends State<LeadManagementPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<LeadModel> leads;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Dummy data for leads list
    leads = [
      LeadModel(
        name: 'Rajbir',
        interactionType: 'chat',
        lastInteractionTime: DateTime.now().subtract(Duration(minutes: 15)),
        isMissed: false,
      ),
      LeadModel(
        name: 'Rajbir',
        interactionType: 'outgoing',
        lastInteractionTime: DateTime.now().subtract(Duration(minutes: 15)),
        isMissed: false,
      ),
      LeadModel(
        name: 'Rajbir',
        interactionType: 'incoming',
        lastInteractionTime: DateTime.now().subtract(Duration(minutes: 15)),
        isMissed: false,
      ),
      LeadModel(
        name: 'Rajbir',
        interactionType: 'missed',
        lastInteractionTime: DateTime.now().subtract(Duration(minutes: 15)),
        isMissed: false,
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          SizedBox(height: 22), // Menambahkan spacer/jarak antara AppBar dan TabButton
          Container(
            color: Colors.white, // Sesuaikan dengan desain
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TabButton(text: 'Leads', index: 0, tabController: _tabController),
                TabButton(text: 'Demo Class', index: 1, tabController: _tabController),
                TabButton(text: 'Chats/Calls', index: 2, tabController: _tabController),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(child: Text('Leads Content')),
                Center(child: Text('Demo Class Content')),
                ListChatCallPage(leads: leads),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

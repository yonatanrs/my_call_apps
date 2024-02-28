// list_chat_call_page.dart
import 'package:flutter/material.dart';
import 'package:call_apps/widgets/lead_item_widget.dart';
import 'package:call_apps/models/lead_model.dart'; // Import the LeadModel class

class ListChatCallPage extends StatelessWidget {
  final List<LeadModel> leads;

  ListChatCallPage({required this.leads});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: leads.length,
      separatorBuilder: (context, index) => Divider(color: Colors.transparent),
      itemBuilder: (context, index) {
        return LeadItemWidget(lead: leads[index]);
      },
    );
  }
}

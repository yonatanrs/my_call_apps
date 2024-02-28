import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:call_apps/models/lead_model.dart';
import 'package:call_apps/pages/incoming_call_page.dart';
import 'package:call_apps/pages/callback_page.dart';
import 'package:call_apps/pages/chat_message_page.dart';

class LeadItemWidget extends StatelessWidget {
  final LeadModel lead;

  LeadItemWidget({required this.lead});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    String message;
    Color iconColor;
    Color messageColor; // Tambahkan warna teks

    switch (lead.interactionType) {
      case 'chat':
        icon = Icons.chat;
        message = 'Chat';
        iconColor = Colors.black;
        messageColor = Colors.black; // Warna teks untuk 'chat'
        break;
      case 'outgoing':
        icon = Icons.add_ic_call_sharp;
        message = 'Outgoing call';
        iconColor = Colors.black;
        messageColor = Colors.green; // Warna teks untuk 'outgoing'
        break;
      case 'incoming':
        icon = Icons.phone_callback_rounded;
        message = 'Incoming call';
        iconColor = Colors.black;
        messageColor = Colors.green; // Warna teks untuk 'incoming'
        break;
      case 'missed':
        icon = Icons.phone_missed_rounded;
        message = 'Missed call';
        iconColor = Colors.red;
        messageColor = Colors.red; // Warna teks untuk 'missed'
        break;
      default:
        icon = Icons.error_outline;
        message = 'Unknown';
        iconColor = Colors.black;
        messageColor = Colors.black;
        break;
    }

    return GestureDetector(
      onTap: () => _handleTap(context),
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lead.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    message,
                    style: TextStyle(
                      color: messageColor, // Gunakan warna teks yang sesuai
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              timeago.format(lead.lastInteractionTime),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
            if (lead.isMissed) ...[
              SizedBox(width: 16),
              Icon(Icons.phone_missed, color: Colors.red),
            ],
          ],
        ),
      ),
    );
  }

  void _handleTap(BuildContext context) {
    if (lead.interactionType == 'incoming') {
      Get.to(() => IncomingCallPage(lead: lead));
    } else {
      _showOptionsDialog(context);
    }
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Choose an action',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.chat, color: Colors.blue),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        Get.to(() => ChatPage(lead: lead)); // Navigate to ChatMessagePage
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.phone, color: Colors.green),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog first
                        Get.to(() => CallbackPage(lead: lead)); // Navigate to CallbackPage
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

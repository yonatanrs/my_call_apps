import 'package:flutter/material.dart';
import 'package:call_apps/models/lead_model.dart';
import 'package:file_picker/file_picker.dart';

class ChatPage extends StatefulWidget {
  final LeadModel lead;

  ChatPage({required this.lead});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<String> messages = [];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: widget.lead.profileImage != null
                  ? NetworkImage(widget.lead.profileImage!)
                  : AssetImage('assets/default_profile.jpeg') as ImageProvider,
              radius: 16,
            ),
            SizedBox(width: 10),
            Text('Chat with ${widget.lead.name}'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Implement options action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) => ListTile(
                title: Align(
                  alignment: Alignment.centerRight, // Assuming all messages sent by the user
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(messages[index]),
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 1),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70,
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: () async {
              try {
                FilePickerResult? result = await FilePicker.platform.pickFiles();

                if (result != null) {
                  PlatformFile file = result.files.first;
                  setState(() {
                    messages.add('File: ${file.name}');
                  });
                } else {
                  // User canceled the picker
                }
              } catch (e) {
                print("Error picking file: $e");
                // Handle the exception
              }
            },

          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                setState(() {
                  messages.add(_controller.text);
                  _controller.clear();
                });
              }
            },
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:call_apps/models/lead_model.dart';

class CallbackPage extends StatefulWidget {
  final LeadModel lead;

  CallbackPage({required this.lead});

  @override
  _CallbackPageState createState() => _CallbackPageState();
}

class _CallbackPageState extends State<CallbackPage> {
  Timer? _timer;
  int _elapsedTime = 0; // Start from 0 to count forward

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime++; // Increment the elapsed time
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.purpleAccent.withOpacity(0.3),
                child: Text(
                  widget.lead.initials ?? 'R',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 58,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 17),
              Text(
                widget.lead.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Call in Progress: ${_formatTime(_elapsedTime)}',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 180),
              _buildCallButton(context, Icons.call_end, 'Hangover', Colors.red, () {
                Navigator.of(context).pop();
              }),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCallButton(BuildContext context, IconData icon, String label, Color color, VoidCallback onPressed) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: color,
          child: Icon(icon, size: 30),
          elevation: 2,
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  String _formatTime(int totalSeconds) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

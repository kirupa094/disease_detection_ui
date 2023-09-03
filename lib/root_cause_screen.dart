import 'package:flutter/material.dart';

class RootCauseScreen extends StatefulWidget {
  const RootCauseScreen({super.key});

  @override
  State<RootCauseScreen> createState() => _RootCauseScreenState();
}

class _RootCauseScreenState extends State<RootCauseScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 214, 41, 18),
          title: const Text(
            'Root Cause',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: true,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyEncryption extends StatefulWidget {
  const MyEncryption({super.key});

  @override
  State<MyEncryption> createState() => _MyEncryptionState();
}

class _MyEncryptionState extends State<MyEncryption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Encryption'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:developer';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:nize_gallery/encryption/algorithms.dart';
// import 'package:nize_gallery/encryption/algorithms.dart';

class MyEncryption extends StatefulWidget {
  const MyEncryption({super.key});

  @override
  State<MyEncryption> createState() => _MyEncryptionState();
}

class _MyEncryptionState extends State<MyEncryption> {
  final _controller = TextEditingController();
  String encrypted = '';
  String decrypted = '';
  late encrypt.Encrypted encrypter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Encryption'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Text('AES Encryption',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _controller,
              onChanged: (value) {
                if (_controller.text.isEmpty)
                  setState(() {
                    // decrypted = 'Please enter some text';
                    encrypted = 'Please enter some text';
                  });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your text',
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    setState(() {
                      encrypter = Algorithm.aesEncryption(_controller.text);
                      log(encrypter.toString());
                      encrypted = Algorithm.aesEncryption(_controller.text)
                          .base64
                          .toString();
                    });
                  }
                },
                child: const Text('Encrypt'),
              ),
            ),
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Encrypted Text: ',
                    style: Theme.of(context).textTheme.titleLarge),
                SizedBox(width: 10),
                Expanded(
                    child: Text(encrypted,
                        style: Theme.of(context).textTheme.titleSmall)),
              ],
            ),
            SizedBox(height: 60),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    decrypted = Algorithm.aesDecrytion(encrypter);
                  });
                },
                child: const Text('Decrypt'),
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text('Decrypted Text: ',
                    style: Theme.of(context).textTheme.titleLarge),
                SizedBox(width: 10),
                Text(decrypted, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

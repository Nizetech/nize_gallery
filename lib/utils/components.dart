import 'package:flutter/material.dart';

Widget drawer() => Container(
    width: 221,
    height: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 2,
          spreadRadius: 1,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        ListTile(
          leading: const Icon(Icons.memory_rounded),
          title: const Text('Internal Memory'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.sd_card),
          title: const Text('SD Card'),
          onTap: () {},
        ),
      ],
    ));

import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notif Screen'),
      ),
      body: const Center(
        child: Text('Anggap aja ini halaman notifikasi'),
      ),
    );
  }
}

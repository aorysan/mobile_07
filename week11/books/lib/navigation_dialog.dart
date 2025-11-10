import 'package:flutter/material.dart';

class NavigationDialog extends StatefulWidget {
  const NavigationDialog({super.key});

  @override
  State<NavigationDialog> createState() => _NavigationDialogState();
}

class _NavigationDialogState extends State<NavigationDialog> {
  Color color = Colors.blue.shade700;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text('Navigasi Dialog Aryok'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Ganti warna'),
          onPressed: () {
            _showColorDialog(context);
          },
        ),
      ),
    );
  }

  _showColorDialog(BuildContext context) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Sangat penting sekali '),
          content: const Text('Pilih warna wok'),
          actions: <Widget>[
            TextButton(
              child: const Text('Blue'),
              onPressed: () {
                color = const Color.fromARGB(255, 0, 170, 255);
                Navigator.pop(context, color);
              },
            ),
            TextButton(
              child: const Text('Grey'),
              onPressed: () {
                color = const Color.fromARGB(255, 114, 114, 114);
                Navigator.pop(context, color);
              },
            ),
            TextButton(
              child: const Text('Black'),
              onPressed: () {
                color = const Color.fromARGB(255, 0, 0, 0);
                Navigator.pop(context, color);
              },
            ),
          ],
        );
      },
    );
    setState(() {});
  }
}

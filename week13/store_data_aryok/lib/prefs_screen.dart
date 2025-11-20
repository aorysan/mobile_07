import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsScreen extends StatefulWidget {
  const PrefsScreen({super.key});

  @override
  State<PrefsScreen> createState() => _PrefsScreenState();
}

class _PrefsScreenState extends State<PrefsScreen> {
  int appCounter = 0;

  @override
  void initState() {
    super.initState();
    readAndWritePreference();
  }

  Future<void> readAndWritePreference() async {
    // Dapatkan instance SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Baca nilai appCounter, gunakan 0 sebagai default jika belum ada
    appCounter = prefs.getInt('appCounter') ?? 0;

    // Increment counter
    appCounter++;

    // Simpan nilai baru
    await prefs.setInt('appCounter', appCounter);

    // Update UI
    setState(() {});
  }

  Future<void> deletePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      appCounter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences - Aryok'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have opened the app',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '$appCounter times',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                deletePreference();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Reset counter'),
            ),
          ],
        ),
      ),
    );
  }
}

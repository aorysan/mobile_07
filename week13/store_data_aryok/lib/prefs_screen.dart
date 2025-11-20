import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class PrefsScreen extends StatefulWidget {
  const PrefsScreen({super.key});

  @override
  State<PrefsScreen> createState() => _PrefsScreenState();
}

class _PrefsScreenState extends State<PrefsScreen> {
  int appCounter = 0;
  String documentsPath = '';
  String tempPath = '';

  @override
  void initState() {
    super.initState();
    readAndWritePreference();
    getPaths();
  }

  Future<void> getPaths() async {
    final docDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();
    setState(() {
      documentsPath = docDir.path;
      tempPath = tempDir.path;
    });
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Counter Section
            Center(
              child: Column(
                children: [
                  const Text(
                    'You have opened the app',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '$appCounter times',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
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
            const SizedBox(height: 40),
            const Divider(),
            const SizedBox(height: 20),
            // Path Provider Section
            const Text(
              'File System Paths:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Documents Directory:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      documentsPath.isEmpty ? 'Loading...' : documentsPath,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Temporary Directory:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tempPath.isEmpty ? 'Loading...' : tempPath,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

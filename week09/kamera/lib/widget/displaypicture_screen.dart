import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';
import 'filter_selector.dart';

class DisplayPictureScreen extends StatefulWidget {
  final XFile imageFile;

  const DisplayPictureScreen({super.key, required this.imageFile});

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  static const List<Color> _filterColors = [
    Colors.transparent,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink,
  ];

  late Color _selectedFilter;

  @override
  void initState() {
    super.initState();
    // FilterSelector centers the active item in the middle of the viewport.
    // With _filtersPerScreen == 5 the centered index is 2, so default the
    // selected filter to the item at index 2 to match the visual selection.
    _selectedFilter = _filterColors[2];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture - 2341720084')),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Uint8List>(
              future: widget.imageFile.readAsBytes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.memory(snapshot.data!, fit: BoxFit.contain),
                      // color overlay to preview filter
                      IgnorePointer(
                        child: Container(
                          color: _selectedFilter.withOpacity(
                            _selectedFilter == Colors.transparent ? 0.0 : 0.35,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading image'));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          SizedBox(
            height: 100,
            child: FilterSelector(
              filters: _filterColors,
              onFilterChanged: (color) =>
                  setState(() => _selectedFilter = color),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:async/async.dart';
// import 'dart:async';
// import 'package:http/http.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'geolocation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Map<String, double>> getLocation() async {
    // Ganti dengan pemanggilan fungsi lokasi asli jika ada di geolocation.dart
    // Contoh: return await Geolocation.getCurrentPosition();
    await Future.delayed(const Duration(seconds: 5));
    // Contoh data mock
    double latitude = -6.200000;
    double longitude = 106.816666;
    return {'latitude': latitude, 'longitude': longitude};
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Async gwej (Aryok)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Lokasi Aryok sekarang')),
        body: Center(
          child: FutureBuilder<Map<String, double>>(
            future: getLocation(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: \\${snapshot.error}');
              } else if (snapshot.hasData) {
                final lat = snapshot.data?['latitude'];
                final lon = snapshot.data?['longitude'];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Latitude: \\${lat ?? '-'}'),
                    Text('Longitude: \\${lon ?? '-'}'),
                  ],
                );
              } else {
                return const Text('Tidak ada lokasi');
              }
            },
          ),
        ),
      ),
    );
  }
}

// class FuturePage extends StatefulWidget {
//   const FuturePage({super.key});

//   @override
//   State<FuturePage> createState() => _FuturePageState();
// }

// class _FuturePageState extends State<FuturePage> {
//   Future handleError() async {
//     try {
//       await returnError();
//     } catch (e) {
//       setState(() {
//         result = e.toString();
//       });
//     } finally {
//       print('Kelar wok');
//     }
//   }

//   Future returnError() async {
//     await Future.delayed(const Duration(seconds: 2));
//     throw Exception('Error walaw e!');
//   }

//   void returnFG() {
//     // FutureGroup<int> futureGroup = FutureGroup<int>();
//     // futureGroup.add(returnOneAsync());
//     // futureGroup.add(returnTwoAsync());
//     // futureGroup.add(returnThreeAsync());
//     // futureGroup.close();

//     final futures = Future.wait<int>([
//       returnOneAsync(),
//       returnTwoAsync(),
//       returnThreeAsync(),
//     ]);

//     futures.then((List<int> values) {
//       int total = 0;
//       for (var value in values) {
//         total += value;
//       }
//       setState(() {
//         result = total.toString();
//       });
//     });
//   }

//   late Completer completer;

//   Future getNumber() {
//     completer = Completer<int>();
//     calculate();
//     return completer.future;
//   }

//   // Future calculate() async {
//   //   await Future.delayed(const Duration(seconds: 5));
//   //   completer.complete(42);
//   // }

//   calculate() async {
//     try {
//       await new Future.delayed(const Duration(seconds: 5));
//       completer.complete(42);
//     } catch (e) {
//       completer.completeError(e);
//     }
//   }

//   Future<int> returnOneAsync() async {
//     await Future.delayed(const Duration(seconds: 3));
//     return 1;
//   }

//   Future<int> returnTwoAsync() async {
//     await Future.delayed(const Duration(seconds: 3));
//     return 2;
//   }

//   Future<int> returnThreeAsync() async {
//     await Future.delayed(const Duration(seconds: 3));
//     return 3;
//   }

//   Future count() async {
//     int total = 0;
//     total = await returnOneAsync();
//     total += await returnTwoAsync();
//     total += await returnThreeAsync();

//     setState(() {
//       result = total.toString();
//     });
//   }

//   Future<Response> getData() async {
//     const authority = 'www.googleapis.com';
//     const path = '/books/v1/volumes/MbOkkqDEJbkC';
//     Uri url = Uri.https(authority, path);

//     return http.get(url);
//   }

//   String result = '';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Back from the Future')),
//       body: Center(
//         child: Column(
//           children: [
//             const Spacer(),
//             ElevatedButton(
//               child: const Text('GO!'),
//               onPressed: () {
//                 handleError();
//               },
//             ),
//             const Spacer(),
//             Text(result),
//             const Spacer(),
//             const CircularProgressIndicator(),
//             const Spacer(),
//           ],
//         ),
//       ),
//     );
//   }
// }

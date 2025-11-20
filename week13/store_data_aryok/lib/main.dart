import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'model/pizza.dart';
import 'prefs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store Data - Aryok',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Store Data - Aryok'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pizza> myPizzas = [];

  @override
  void initState() {
    super.initState();
    readJsonFile().then((pizzas) {
      setState(() {
        myPizzas = pizzas;
      });
    });
  }

  Future<List<Pizza>> readJsonFile() async {
    // Membaca file JSON dari assets
    final String myString = await rootBundle.loadString(
      'assets/pizzalist.json',
    );

    // Decode JSON string menjadi List of Maps
    final List pizzaMapList = jsonDecode(myString);

    // Konversi List of Maps menjadi List of Pizza objects
    final List<Pizza> myPizzas = pizzaMapList.map((pizzaMap) {
      return Pizza.fromJson(pizzaMap);
    }).toList();

    // Konversi kembali ke JSON untuk testing (serialization)
    String json = convertToJSON(myPizzas);
    print(json);

    return myPizzas;
  }

  String convertToJSON(List<Pizza> pizzas) {
    return jsonEncode(pizzas.map((pizza) => pizza.toJson()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.storage),
            tooltip: 'SharedPreferences Demo',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrefsScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: myPizzas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  myPizzas[index].pizzaName.isNotEmpty
                      ? myPizzas[index].pizzaName
                      : 'No name',
                ),
                Text(
                  '\$${myPizzas[index].price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              myPizzas[index].description.isNotEmpty
                  ? myPizzas[index].description
                  : 'No description',
            ),
          );
        },
      ),
    );
  }
}

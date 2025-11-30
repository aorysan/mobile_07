import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pizza.dart';

class HttpHelper {
  // Singleton pattern implementation
  static final HttpHelper _httpHelper = HttpHelper._internal();
  HttpHelper._internal();
  factory HttpHelper() {
    return _httpHelper;
  }

  // ALTERNATIF 1: Gunakan JSONPlaceholder untuk testing
  // final String authority = 'jsonplaceholder.typicode.com';
  // final String path = 'posts'; // Ini akan return data berbeda, tapi untuk test koneksi

  // ALTERNATIF 2: Gunakan raw.githubusercontent.com
  final String authority = 'raw.githubusercontent.com';
  final String path = 'aorysan/mobile_07/main/week14/api/assets/pizzalist.json';

  Future<List<Pizza>> getPizzaList() async {
    final Uri url = Uri.https(authority, path);
    print('Requesting URL: $url'); // Debug: print URL

    try {
      final http.Response result = await http.get(url);
      print('Status Code: ${result.statusCode}'); // Debug: print status code
      print('Response Body: ${result.body}'); // Debug: print response

      if (result.statusCode == HttpStatus.ok) {
        final jsonResponse = json.decode(result.body);
        // Provide a type argument to the map method to avoid type error
        List<Pizza> pizzas = jsonResponse
            .map<Pizza>((i) => Pizza.fromJson(i))
            .toList();
        print('Pizzas loaded: ${pizzas.length}'); // Debug: print count
        return pizzas;
      } else {
        print('Error: Status code ${result.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception occurred: $e'); // Debug: print exception
      return [];
    }
  }
}

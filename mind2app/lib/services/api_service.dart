import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000"; // change if emulator

  // REGISTER USER
  static Future<bool> registerUser(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/users/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  // GET CATEGORIES
  static Future<List<dynamic>> getCategories() async {
    final response =
        await http.get(Uri.parse("$baseUrl/categories/"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load categories");
    }
  }

  // GET PRODUCTS BY CATEGORY
  static Future<List<dynamic>> getProducts(int catId) async {
    final response = await http.get(
      Uri.parse("$baseUrl/products/category/$catId"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load products");
    }
  }
}

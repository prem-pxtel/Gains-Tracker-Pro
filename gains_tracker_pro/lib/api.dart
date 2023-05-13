import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiConstants {
  static String baseUrl = 'https://type.fit/api/quotes';
}

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

List<Quote> quoteFromJson(String str) => List<Quote>.from(json.decode(str).map((x) => Quote.fromJson(x)));

String quoteToJson(List<Quote> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quote {
    String text;
    String? author;

    Quote({
        required this.text,
        this.author,
    });

    factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        text: json["text"],
        author: json["author"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "author": author,
    };
}

class ApiService {
  Future<List<Quote>?> getQuotes() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Quote> model = quoteFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
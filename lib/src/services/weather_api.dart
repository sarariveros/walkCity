import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class WeaterApiProvider {
  Client client = Client();
  final _apiKey = 'fd06e06f3e6e43f5a3e02135220812 ';
  final String _location = '-13.16,-74.22';
  final Map<String, dynamic> clima = {
    'temp_c': '',
    'temp_f': '',
    'text': '',
    'icon': '',
  };

  Future<Map<String, dynamic>> getweather() async {
    final response = await client.get(
      Uri(
        scheme: 'https',
        host: 'api.weatherapi.com',
        path: 'v1/forecast.json',
        queryParameters: {'key': _apiKey, 'q': _location, 'aqi': 'no'},
      ),
    );

// If the call to the server was successful, parse the JSON
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      print(jsonData);

      clima['temp_f'] =
          jsonData['forecast']['forecastday'][0]['day']['maxtemp_f'];
      clima['temp_c'] =
          jsonData['forecast']['forecastday'][0]['day']['maxtemp_c'];
      clima['text'] =
          jsonData['forecast']['forecastday'][0]['day']['condition']['text'];
      clima['icon'] =
          jsonData['forecast']['forecastday'][0]['day']['condition']['icon'];

      return clima;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Weather');
    }
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  String apiKey = 'api_anahtarınız_buraya'; // your_api_key

  WeatherService();

  Future<dynamic> getWeatherData({double? latitude, double? longitude}) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '⛈️';
    } else if (condition < 400) {
      return '🌧️';
    } else if (condition < 600) {
      return '☔';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫️';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temperature) {
    if (temperature > 35) {
      return 'Aşırı sıcak';
    } else if (temperature > 25) {
      return 'Sıcak';
    } else if (temperature > 20) {
      return 'Ilgın';
    } else if (temperature > 10) {
      return 'Serin';
    } else if (temperature > 0) {
      return 'Soğuk';
    } else {
      return 'Aşırı soğuk';
    }
  }

}


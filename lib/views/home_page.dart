import 'package:flutter/material.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/services/weather_service.dart';



class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  WeatherService weatherService = WeatherService();
  Location location = Location();
  String temperature = '';
  String cityName = '';
  String weatherIcon = '';
  String weatherMessage = '';

  @override
  void initState() {
    super.initState();
    getCurrentLocationWeather();
  }

  void getCurrentLocationWeather() async {
    await location.getCurrentLocation();
    var weatherData = await weatherService.getWeatherData(
        latitude: location.latitude, longitude: location.longitude);
    setState(() {
      if (weatherData == null) {
        temperature = 'N/A';
        cityName = 'N/A';
        weatherIcon = 'N/A';
        weatherMessage = 'Hava durumu bilgisi alınamadı';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toStringAsFixed(1);
      cityName = weatherData['name'];
      int condition = weatherData['weather'][0]['id'];
      weatherIcon = weatherService.getWeatherIcon(condition);
      weatherMessage = weatherService.getMessage(temp.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hava Durumu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$temperature°C',
              style: const TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              cityName,
              style: const TextStyle(
                fontSize: 40.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  weatherIcon,
                  style: const TextStyle(
                    fontSize: 40.0,
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Text(
                  weatherMessage,
                  style: const TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../database/database.dart';


class WeatherData {
  final double temperature;
  final int humidity;
  final int weatherCode;
  final List<HourlyForecast> hourlyForecast;
  final DateTime lastUpdated;
  final bool isLive;

  WeatherData({
    required this.temperature,
    required this.humidity,
    required this.weatherCode,
    required this.hourlyForecast,
    required this.lastUpdated,
    required this.isLive,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json, {required bool live}) {
    final current = json['current'];
    final hourly = json['hourly'];

    List<HourlyForecast> forecastList = [];
    List<String> times = List<String>.from(hourly['time']);
    List<double> temps = List<double>.from(hourly['temperature_2m']);


    int startIndex = times.indexWhere((t) => DateTime.parse(t).isAfter(DateTime.now())) -1;
    if (startIndex < 0) startIndex = 0;

    for (int i = startIndex; i < startIndex + 24 && i < times.length; i++) {
      forecastList.add(HourlyForecast(
        time: DateTime.parse(times[i]),
        temperature: temps[i],
      ));
    }

    return WeatherData(
      temperature: current['temperature_2m'] as double,
      humidity: current['relative_humidity_2m'] as int,
      weatherCode: current['weather_code'] as int,
      hourlyForecast: forecastList,
      lastUpdated: DateTime.parse(current['time']),
      isLive: live,
    );
  }
}

class HourlyForecast {
  final DateTime time;
  final double temperature;
  HourlyForecast({required this.time, required this.temperature});
}


class WeatherService {
  final AppDatabase db;

  static const String _apiUrl =
      'https://api.open-meteo.com/v1/forecast?latitude=-22.50&longitude=-43.18&current=temperature_2m,relative_humidity_2m,weather_code&hourly=temperature_2m&timezone=America/Sao_Paulo';

  WeatherService(this.db);

  Future<WeatherData> getWeatherData() async {
    final connectivityResult = await (Connectivity().checkConnectivity());


    if (connectivityResult.contains(ConnectivityResult.none)) {

      final cache = await db.getLastWeather();
      if (cache != null) {
        final json = jsonDecode(cache.jsonData);

        return WeatherData.fromJson(json, live: false);
      } else {
        throw Exception('Você está offline e não há dados salvos.');
      }
    }


    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        await db.cacheWeather(response.body);

        return WeatherData.fromJson(json, live: true);
      } else {
        throw Exception('Falha ao carregar dados da API.');
      }
    } catch (e) {

      final cache = await db.getLastWeather();
      if (cache != null) {
        final json = jsonDecode(cache.jsonData);
        return WeatherData.fromJson(json, live: false);
      } else {
        throw Exception('Erro de conexão e sem dados em cache.');
      }
    }
  }
}
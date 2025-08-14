import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../database/database.dart';


class WeatherData {
  final String locationName;
  final double temperature;
  final int humidity;
  final int weatherCode;
  final List<HourlyForecast> hourlyForecast;
  final DateTime lastUpdated;
  final bool isLive;
  final bool isLocation;

  WeatherData({
    required this.locationName,
    required this.temperature,
    required this.humidity,
    required this.weatherCode,
    required this.hourlyForecast,
    required this.lastUpdated,
    required this.isLive,
    required this.isLocation
  });

  factory WeatherData.fromJson(Map<String, dynamic> json, {required bool live, required String name, required bool locationOnOff}) {
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
      locationName: name,
      temperature: current['temperature_2m'] as double,
      humidity: current['relative_humidity_2m'] as int,
      weatherCode: current['weather_code'] as int,
      hourlyForecast: forecastList,
      lastUpdated: DateTime.parse(current['time']),
      isLive: live,
      isLocation: locationOnOff
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

  WeatherService(this.db);

  Future<WeatherData> getWeatherData() async {

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return _loadFromCacheOrThrow("Você está offline.");
    }

    String apiUrl;
    String locationName;
    bool isLocation;

    try {
      Position position = await _getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      final placemark = placemarks.first;
      locationName = (placemark.locality?.isNotEmpty == true ? placemark.locality : placemark.subAdministrativeArea) ?? 'Local Desconhecido';
      isLocation = true;

      apiUrl = 'https://api.open-meteo.com/v1/forecast?latitude=${position.latitude}&longitude=${position.longitude}&current=temperature_2m,relative_humidity_2m,weather_code&hourly=temperature_2m&timezone=America/Sao_Paulo';

    } catch (e) {

      print(">>> Falha ao obter localização: $e. Usando localização padrão.");
      locationName = 'Petrópolis, RJ (Padrão)';
      isLocation = false;

      apiUrl = 'https://api.open-meteo.com/v1/forecast?latitude=-22.50&longitude=-43.18&current=temperature_2m,relative_humidity_2m,weather_code&hourly=temperature_2m&timezone=America/Sao_Paulo';
    }


    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        await db.cacheWeather(response.body);
        return WeatherData.fromJson(json, live: true, name: locationName, locationOnOff : isLocation);
      } else {

        return _loadFromCacheOrThrow("Falha na API.");
      }
    } catch(e) {

      return _loadFromCacheOrThrow("Erro de conexão com a API.");
    }
  }


  Future<WeatherData> _loadFromCacheOrThrow(String errorContext) async {
    final cache = await db.getLastWeather();
    if (cache != null) {
      final json = jsonDecode(cache.jsonData);
      return WeatherData.fromJson(json, live: false, name: "Últimos dados salvos", locationOnOff: false);
    } else {
      throw Exception('$errorContext E não há dados em cache.');
    }
  }


  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Serviços de localização estão desativados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permissão de localização negada.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('A permissão de localização foi negada permanentemente.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
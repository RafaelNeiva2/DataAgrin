import 'package:farmweather/pages/tasks_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';
import '../services/weather_service.dart';
import '../util/app_bar.dart';
import '../util/bottom_nav_bar.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Future<WeatherData>? _weatherDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  void _fetchWeather() {
    final weatherService = WeatherService(Provider.of<AppDatabase>(context, listen: false));
    setState(() {
      _weatherDataFuture = weatherService.getWeatherData();
    });
  }

  void _onNavBarTap(int index) {
    if (index == 1) return;
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TodoPage()),
      );
    }
  }


  IconData _getWeatherIcon(int code) {
    if (code == 0) return Icons.wb_sunny;
    if (code >= 1 && code <= 3) return Icons.cloud;
    if (code >= 45 && code <= 48) return Icons.foggy;
    if (code >= 51 && code <= 67) return Icons.water_drop;
    if (code >= 71 && code <= 77) return Icons.ac_unit;
    if (code >= 80 && code <= 99) return Icons.thunderstorm;
    return Icons.thermostat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: 1,
        onTap: _onNavBarTap,
      ),
      body: RefreshIndicator(
        onRefresh: () async => _fetchWeather(),
        child: FutureBuilder<WeatherData>(
          future: _weatherDataFuture,
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }


            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Erro: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              );
            }


            if (snapshot.hasData) {
              final weather = snapshot.data!;
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildStatusIndicator(weather.isLive, weather.lastUpdated),
                    const SizedBox(height: 24),
                    _buildCurrentWeather(weather),
                    const SizedBox(height: 32),
                    _buildHourlyForecast(weather.hourlyForecast),
                  ],
                ),
              );
            }

            return const Center(child: Text("Iniciando..."));
          },
        ),
      ),
    );
  }


  Widget _buildStatusIndicator(bool isLive, DateTime lastUpdated) {
    return Card(
      color: isLive ? Colors.green[50] : Colors.blueGrey[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: isLive ? Colors.green : Colors.blueGrey),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isLive ? Icons.wifi : Icons.wifi_off,
              color: isLive ? Colors.green : Colors.blueGrey,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              isLive ? 'Dados Ao Vivo' : 'Dados em Cache',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isLive ? Colors.green.shade800 : Colors.blueGrey.shade800,
              ),
            ),
            const Spacer(),
            Text(
              'Últ. At: ${DateFormat('HH:mm').format(lastUpdated)}',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentWeather(WeatherData weather) {
    return Column(
      children: [
        Icon(_getWeatherIcon(weather.weatherCode), size: 100, color: Colors.amber),
        const SizedBox(height: 16),
        Text(
          '${weather.temperature.toStringAsFixed(1)}°C',
          style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
        ),
        Text(
          'Umidade: ${weather.humidity}%',
          style: const TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ],
    );
  }


  Widget _buildHourlyForecast(List<HourlyForecast> forecast) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Próximas Horas',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: forecast.length,
            itemBuilder: (context, index) {
              final item = forecast[index];
              return Container(
                width: 70,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(item.time),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Icon(Icons.thermostat, color: Colors.blue, size: 24),
                    Text(
                      '${item.temperature.toStringAsFixed(0)}°',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
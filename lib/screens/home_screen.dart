import 'package:flutter/material.dart';
import 'package:weather_app/APIs/get_weather_data.dart';
import 'package:weather_app/widgets/additional_information.dart';
import 'package:weather_app/widgets/hourly_forecast.dart';
import 'package:weather_app/widgets/overview_card.dart';
import 'package:weather_app/constants/city_names.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String cityName = "London";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getWeatherData(cityName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text(
              snapshot.error.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ));
          }

          final weatherInfo = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton(
                          hint: const Text("Change City"),
                          items: cityNames.map((city) {
                            return DropdownMenuItem(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              cityName = newValue.toString();
                            });
                          }),
                      const Text("Weather App"),
                      IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: const Icon(Icons.refresh)),
                    ]),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(cityName,
                      style: const TextStyle(
                          fontSize: 64, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 20),

                  // Overview Card
                  OverviewCard(weatherInfo: weatherInfo),
                  const SizedBox(height: 20),

                  // Hourly Forecast
                  HourlyForecast(weatherInfo: weatherInfo),
                  const SizedBox(height: 20),

                  // Additional Information
                  AdditionalInformation(weatherInfo: weatherInfo),
                ],
              ),
            ),
          );
        });
  }
}

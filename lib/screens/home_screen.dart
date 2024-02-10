import 'package:flutter/material.dart';

import 'package:weather_app/APIs/get_weather_data.dart';
import 'package:weather_app/widgets/additional_information.dart';
import 'package:weather_app/widgets/hourly_forecast.dart';
import 'package:weather_app/widgets/overview_card.dart';
import 'package:weather_app/widgets/search_area.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String cityName = "Karachi";
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
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton(
                          hint: const Text("Pakistani Cities"),
                          items: const [
                            DropdownMenuItem(
                              value: "Karachi",
                              child: Text("Karachi"),
                            ),
                            DropdownMenuItem(
                              value: "Islamabad",
                              child: Text("Islamabad"),
                            ),
                            DropdownMenuItem(
                              value: "Faisalabad",
                              child: Text("Faisalabad"),
                            ),
                            DropdownMenuItem(
                              value: "Lahore",
                              child: Text("Lahore"),
                            ),
                            DropdownMenuItem(
                              value: "Peshawar",
                              child: Text("Peshawar"),
                            ),
                            DropdownMenuItem(
                              value: "Quetta",
                              child: Text("Quetta"),
                            ),
                          ],
                          onChanged: (newValue) {
                            setState(() {
                              cityName = newValue.toString();
                            });
                          }),
                      IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: const Icon(Icons.refresh)),
                    ]),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Search Area
                    SearchArea(cityName: cityName),
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
            ),
          );
        });
  }
}

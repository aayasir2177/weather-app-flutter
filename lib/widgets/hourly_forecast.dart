import 'package:flutter/material.dart';
// import 'package:string_capitalize/string_capitalize.dart';
import 'package:intl/intl.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({super.key, required this.weatherInfo});

  final Map<String, dynamic> weatherInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hourly Forecast",
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 120,
          child: ListView.builder(
            physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (context, index) {
              String dateTimeString =
                  weatherInfo["hourlyWeather"][index + 1]["dt_txt"];

              DateTime dateTime = DateTime.parse(dateTimeString);

              return SizedBox(
                width: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          " ${DateFormat.jm().format(dateTime)}",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Icon(
                          weatherInfo["hourlyWeather"][index + 1]["weather"][0]
                                      ["main"] ==
                                  "Clouds"
                              ? Icons.cloud
                              : Icons.sunny,
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${weatherInfo["hourlyWeather"][index + 1]["main"]["temp"]}° F",
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

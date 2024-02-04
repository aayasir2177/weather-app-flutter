import 'dart:ui';
import 'package:string_capitalize/string_capitalize.dart';
import 'package:flutter/material.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({super.key, required this.weatherInfo});

  final Map<String, dynamic> weatherInfo;

  @override
  Widget build(BuildContext context) {
    final String temperatureCelsius =
        ((weatherInfo["temperature"] - 32) * (5 / 9)).toStringAsFixed(2);

    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(children: [
                Text("${weatherInfo["temperature"]}° F",
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 3),
                Text("$temperatureCelsius° C",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.normal)),
                const SizedBox(height: 6),
                Icon(
                  weatherInfo["weather"] == "Clouds"
                      ? Icons.cloud
                      : Icons.sunny,
                  size: 54,
                ),
                const SizedBox(height: 10),
                Text(
                  weatherInfo["weatherDescription"].toString().capitalizeEach(),
                  style: const TextStyle(fontSize: 18),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

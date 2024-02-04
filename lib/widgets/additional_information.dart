import 'package:flutter/material.dart';

class AdditionalInformation extends StatelessWidget {
  const AdditionalInformation({super.key, required this.weatherInfo});

  final Map<String, dynamic> weatherInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Additional Information",
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(12),
              child: Ink(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const Icon(Icons.water_drop),
                    const SizedBox(height: 8),
                    const Text("Humidity"),
                    const SizedBox(height: 8),
                    Text("${weatherInfo["humidity"]} %")
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(12),
              child: Ink(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const Icon(Icons.air),
                    const SizedBox(height: 8),
                    const Text("Wind Speed"),
                    const SizedBox(height: 8),
                    Text("${weatherInfo["windSpeed"]} mph")
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(12),
              child: Ink(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const Icon(Icons.beach_access),
                    const SizedBox(height: 8),
                    const Text("Pressure"),
                    const SizedBox(height: 8),
                    Text("${weatherInfo["pressure"]} hPa")
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

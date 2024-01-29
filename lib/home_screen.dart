import 'dart:convert' as convert;
import 'dart:math';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Map<String, dynamic>> getData() async {
    String apiKey = "2815db7bce2c4d5be6d4ba35ab9c949f";
    String cityName = "London";

    var uri = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&units=imperial&appid=$apiKey");

    var response = await http.get(uri);

    var decodedData = convert.jsonDecode(response.body);

    // Current Weather
    final temperature = decodedData["list"][0]["main"]["temp"];
    final weather = decodedData["list"][0]["weather"][0]["main"];
    final weatherDescription =
        decodedData["list"][0]["weather"][0]["description"];
    final humidity = decodedData["list"][0]["main"]["humidity"];
    final windSpeed = decodedData["list"][0]["wind"]["speed"];
    final pressure = decodedData["list"][0]["main"]["pressure"];

    // Hourly Weather
    final hourlyWeather = decodedData["list"];

    final Map<String, dynamic> data = {
      "temperature": temperature,
      "weather": weather,
      "weatherDescription": weatherDescription,
      "humidity": humidity,
      "windSpeed": windSpeed,
      "pressure": pressure,
      "hourlyWeather": hourlyWeather,
    };

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
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

          final data = snapshot.data!;

          final temperatureCelsius =
              ((data["temperature"] - 32) * (5 / 9)).toStringAsFixed(2);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Weather App"),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: const Icon(Icons.refresh))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overview Card
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(children: [
                              Text("${data["temperature"]}° F",
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 3),
                              Text("$temperatureCelsius° C",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)),
                              const SizedBox(height: 6),
                              Icon(
                                data["weather"] == "Clouds"
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 54,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                data["weatherDescription"]
                                    .toString()
                                    .capitalizeEach(),
                                style: const TextStyle(fontSize: 18),
                              )
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Hourly Forecast
                  const Text(
                    "Hourly Forecast",
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      physics:
                          const ScrollPhysics(parent: BouncingScrollPhysics()),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        String dateTimeString =
                            data["hourlyWeather"][index + 1]["dt_txt"];

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
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Icon(
                                    data["hourlyWeather"][index + 1]["weather"]
                                                [0]["main"] ==
                                            "Clouds"
                                        ? Icons.cloud
                                        : Icons.sunny,
                                    size: 32,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${data["hourlyWeather"][index + 1]["main"]["temp"]}° F",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Additional Information
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
                              Text("${data["humidity"]} %")
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
                              Text("${data["windSpeed"]} mph")
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
                              Text("${data["pressure"]} hPa")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

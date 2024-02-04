import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:weather_app/constants/api_key.dart';

Future<Map<String, dynamic>> getWeatherData(cityName) async {
  var uri = Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&units=imperial&appid=$apiKey");

  var response = await http.get(uri);

  var data = convert.jsonDecode(response.body);

  final Map<String, dynamic> weatherInfo = {
    "temperature": data["list"][0]["main"]["temp"],
    "weather": data["list"][0]["weather"][0]["main"],
    "weatherDescription": data["list"][0]["weather"][0]["description"],
    "humidity": data["list"][0]["main"]["humidity"],
    "windSpeed": data["list"][0]["wind"]["speed"],
    "pressure": data["list"][0]["main"]["pressure"],
    "hourlyWeather": data["list"],
  };

  return weatherInfo;
}

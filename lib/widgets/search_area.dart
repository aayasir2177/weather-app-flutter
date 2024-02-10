import 'package:flutter/material.dart';
import 'package:string_capitalize/string_capitalize.dart';

import 'package:weather_app/constants/city_names.dart';

class SearchArea extends StatefulWidget {
  String cityName;
  SearchArea({super.key, required this.cityName});

  @override
  State<SearchArea> createState() => _SearchAreaState();
}

class _SearchAreaState extends State<SearchArea> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.cityName.capitalizeEach(),
            style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold)),
        const Text("Enter Any City: ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
        SizedBox(
          width: 150,
          child: Autocomplete(
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }

              return cityNames.where((city) {
                return city.contains(textEditingValue.text);
              });
            },
            onSelected: (newValue) {
              setState(() {
                widget.cityName = newValue.toString();
              });
            },
          ),
        ),
      ],
    );
  }
}

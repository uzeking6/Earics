import 'package:flutter/material.dart';

class FrequencySettings extends StatefulWidget {
  const FrequencySettings({super.key});

  @override
  _FrequencySettingsState createState() => _FrequencySettingsState();
}

class _FrequencySettingsState extends State<FrequencySettings> {
  bool noiseReduction = false;
  bool amplifierOD = false;
  List<bool> choiceHear = [true, false]; // for OD and OG
  Map<String, double> frequencies = {
    '250HZ': 0,
    '500HZ': 0,
    '1KHZ': 0,
    '2KHZ': 0,
    '4KHZ': 0,
    '8KHZ': 0,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SwitchListTile(
          title: const Text('Amplify_freq'),
          value: amplifierOD,
          onChanged: (bool value) {
            setState(() {
              amplifierOD = value;
            });
          },
        ),
        ...frequencies.keys.map((String key) {
          return Slider(
            value: frequencies[key]!,
            onChanged: (double value) {
              setState(() {
                frequencies[key] = value;
              });
            },
            min: 0,
            max: 100,
            divisions: 20,
            label: key,
          );
        }),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: () {
              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //     builder: (BuildContext context) =>
              //         HardHearing(title: 'register')));
            },
            child: const Text('SAVE'),
          ),
        ),
      ],
    );
  }
}

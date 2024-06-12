import 'package:firstapp/views/hard_of_hearing.dart';
import 'package:flutter/material.dart';

class Intensity_Settings extends StatefulWidget {
  const Intensity_Settings({super.key});

  @override
  _Intensity_SettingsState createState() => _Intensity_SettingsState();
}

class _Intensity_SettingsState extends State<Intensity_Settings> {
  bool noiseReduction = false;
  bool amplifierOD = false;
  List<bool> choiceHear = [true, false]; // for OD and OG
  Map<String, double> Intensities = {
    '20dB': 0,
    '23dB': 0,
    '29dB': 0,
    '32dB': 0,
    '48dB': 0,
    '58dB': 0,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SwitchListTile(
          title: const Text('Amplify_inten'),
          value: amplifierOD,
          onChanged: (bool value) {
            setState(() {
              amplifierOD = value;
            });
          },
        ),
        ...Intensities.keys.map((String key) {
          return Slider(
            value: Intensities[key]!,
            onChanged: (double value) {
              setState(() {
                Intensities[key] = value;
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
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const HardHearing(title: 'register')));
            },
            child: const Text('SAVE'),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const TemperatureConverterApp());
}

/// The main application widget.
class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        // Set the primary color scheme to purple
        primarySwatch: Colors.purple, // Primary color for app bars, buttons, etc.
        visualDensity: VisualDensity.adaptivePlatformDensity,

        // Customize the TextTheme to use purple colors
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18),
        ).apply(bodyColor: Colors.purple[800], displayColor: Colors.purple[800]),

        // Define button theme with purple colors
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.purple[700], // Button background color
            onPrimary: Colors.white, // Button text color
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      home: const TemperatureConverterPage(),
    );
  }
}

/// A stateful widget that represents the temperature conversion page.
class TemperatureConverterPage extends StatefulWidget {
  const TemperatureConverterPage({super.key});

  @override
  _TemperatureConverterPageState createState() =>
      _TemperatureConverterPageState();
}

class _TemperatureConverterPageState extends State<TemperatureConverterPage> {
  final TextEditingController _controller = TextEditingController();
  String _selectedConversion = 'F to C';
  String _convertedValue = '';
  List<String> _history = [];

  /// Converts the input temperature based on the selected conversion type
  /// and updates the conversion history.
  void _convertTemperature() {
    final input = double.tryParse(_controller.text);
    if (input == null) return;

    double result;
    String historyEntry;

    if (_selectedConversion == 'F to C') {
      result = (input - 32) * 5 / 9;
      historyEntry =
      'F to C: ${input.toStringAsFixed(1)} => ${result.toStringAsFixed(1)}';
    } else {
      result = (input * 9 / 5) + 32;
      historyEntry =
      'C to F: ${input.toStringAsFixed(1)} => ${result.toStringAsFixed(1)}';
    }

    setState(() {
      _convertedValue = result.toStringAsFixed(1);
      _history.insert(0, historyEntry);
    });
  }

  /// Clears the conversion history.
  void _clearHistory() {
    setState(() {
      _history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
        // Change the AppBar background color to purple
        backgroundColor: Colors.purple[800], // Darker purple for AppBar
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedConversion,
                    decoration: const InputDecoration(
                      labelText: 'Conversion Type',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'F to C',
                        child: Text('Fahrenheit to Celsius'),
                      ),
                      DropdownMenuItem(
                        value: 'C to F',
                        child: Text('Celsius to Fahrenheit'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedConversion = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter Temperature',
                      border: const OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.thermostat,
                        color: Colors.purple[800], // Purple icon color
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _convertTemperature,
                    child: const Text(
                      'CONVERT',
                    ),
                  const SizedBox(height: 20),
                  Text(
                    'Converted Value: $_convertedValue',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[800], // Purple text color
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'History',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: _clearHistory,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: orientation == Orientation.portrait ? 300 : 150,
                    child: ListView.builder(
                      itemCount: _history.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(_history[index]),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

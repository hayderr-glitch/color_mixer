import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Mixer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Color Mixer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _red = 0;
  double _green = 0;
  double _blue = 0;

  @override
  Widget build(BuildContext context) {
    final Color mixedColor = Color.fromRGBO(
      _red.toInt(),
      _green.toInt(),
      _blue.toInt(),
      1.0,
    );

    return Scaffold(
      appBar: AppBar(backgroundColor: mixedColor, title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: mixedColor,
                child: Center(
                  child: Text(
                    'RGB(${_red.toInt()}, ${_green.toInt()}, ${_blue.toInt()})',
                    style: TextStyle(
                      color: _red + _green + _blue < 382
                          ? Colors.white
                          : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildColorSlider(
              label: 'R',
              color: Colors.red,
              value: _red,
              onChanged: (value) => setState(() => _red = value),
            ),
            _buildColorSlider(
              label: 'G',
              color: Colors.green,
              value: _green,
              onChanged: (value) => setState(() => _green = value),
            ),
            _buildColorSlider(
              label: 'B',
              color: Colors.blue,
              value: _blue,
              onChanged: (value) => setState(() => _blue = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSlider({
    required String label,
    required Color color,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Row(
      children: [
        SizedBox(width: 20, child: Text(label)),
        Expanded(
          child: Slider(
            value: value,
            min: 0,
            max: 255,
            onChanged: onChanged,
            activeColor: color,
          ),
        ),
        SizedBox(width: 40, child: Text(value.toInt().toString())),
      ],
    );
  }
}

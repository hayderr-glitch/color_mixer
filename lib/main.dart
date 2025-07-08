import 'package:flutter/material.dart';

// The main entry point for the Flutter application.
void main() {
  // runApp inflates the given widget and attaches it to the screen.
  runApp(const MyApp());
}

// MyApp is the root widget of the application.
// It's a StatelessWidget because it doesn't hold any mutable state itself.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // The build method describes how to display the widget in terms of other,
  // lower-level widgets.
  @override
  Widget build(BuildContext context) {
    // MaterialApp is a convenience widget that wraps a number of widgets
    // that are commonly required for Material Design applications.
    return MaterialApp(
      title: 'Color Mixer',
      // ThemeData defines the visual properties of the app, like colors and fonts.
      theme: ThemeData(
        // ColorScheme defines the set of colors for the theme.
        // fromSeed creates a color scheme from a single seed color.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3 enables the newer Material 3 design.
        useMaterial3: true,
      ),
      // The home property defines the default route of the app.
      home: const MyHomePage(title: 'Color Mixer'),
    );
  }
}

// MyHomePage is the main screen of the application.
// It's a StatefulWidget because its appearance can change in response to
// user interactions (like moving a slider).
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// _MyHomePageState holds the mutable state for the MyHomePage widget.
class _MyHomePageState extends State<MyHomePage> {
  // State variables to hold the current value for each color component.
  // They range from 0.0 to 255.0.
  double _red = 0;
  double _green = 0;
  double _blue = 0;

  @override
  Widget build(BuildContext context) {
    // Create a Color object from the current RGB state variables.
    // The opacity is fixed at 1.0 (fully opaque).
    final Color mixedColor = Color.fromRGBO(
      _red.toInt(),
      _green.toInt(),
      _blue.toInt(),
      1.0,
    );

    // Scaffold implements the basic material design visual layout structure.
    return Scaffold(
      // The AppBar at the top of the screen.
      // Its background color dynamically changes to the mixedColor.
      appBar: AppBar(backgroundColor: mixedColor, title: Text(widget.title)),
      // The body of the scaffold.
      body: Padding(
        // Adds padding around the main content.
        padding: const EdgeInsets.all(16.0),
        // Column arranges its children vertically.
        child: Column(
          children: <Widget>[
            // Expanded makes its child (the Container) fill the available
            // vertical space in the Column.
            Expanded(
              child: Container(
                // The container's background color is set to the mixed color.
                color: mixedColor,
                // Center widget centers its child.
                child: Center(
                  // Text widget displays the current RGB values.
                  child: Text(
                    'RGB(${_red.toInt()}, ${_green.toInt()}, ${_blue.toInt()})',
                    style: TextStyle(
                      // This is a simple algorithm to determine if the text should be
                      // black or white for better contrast against the background color.
                      // If the sum of RGB values is less than 382 (255 * 1.5),
                      // the background is considered dark, so we use white text.
                      // Otherwise, we use black text.
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
            // A SizedBox provides a fixed-size box, used here for vertical spacing.
            const SizedBox(height: 20),
            // Calls the helper method to build a slider for the Red component.
            // The onChanged callback updates the `_red` state variable, which
            // triggers a rebuild of the widget.
            _buildColorSlider(
              label: 'R',
              color: Colors.red,
              value: _red,
              onChanged: (value) => setState(() => _red = value),
            ),
            // Calls the helper method to build a slider for the Green component.
            _buildColorSlider(
              label: 'G',
              color: Colors.green,
              value: _green,
              onChanged: (value) => setState(() => _green = value),
            ),
            // Calls the helper method to build a slider for the Blue component.
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

  // A helper method to create a reusable row containing a label, a slider,
  // and a value display. This reduces code duplication.
  Widget _buildColorSlider({
    required String label,
    required Color color,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    // Row arranges its children horizontally.
    return Row(
      children: [
        // A fixed-width box to hold the color label (R, G, or B).
        SizedBox(width: 20, child: Text(label)),
        // Expanded makes the Slider take up all available horizontal space.
        Expanded(
          child: Slider(
            value: value, // The current value of the slider.
            min: 0, // The minimum value of the slider.
            max: 255, // The maximum value of the slider.
            onChanged: onChanged, // The callback when the slider value changes.
            activeColor: color, // The color of the slider's track.
          ),
        ),
        // A fixed-width box to display the current integer value of the slider.
        SizedBox(width: 40, child: Text(value.toInt().toString())),
      ],
    );
  }
}

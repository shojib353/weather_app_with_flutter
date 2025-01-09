import 'package:flutter/material.dart';

class TemperatureProgressBar extends StatefulWidget {
  final int minTemp;
  final int maxTemp;

  TemperatureProgressBar({required this.minTemp, required this.maxTemp});

  @override
  _TemperatureProgressBarState createState() => _TemperatureProgressBarState();
}

class _TemperatureProgressBarState extends State<TemperatureProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double progress;

  @override
  void initState() {
    super.initState();
    progress = getProgressValue(widget.minTemp, widget.maxTemp);

    // Set up the AnimationController
    _controller = AnimationController(
      duration: Duration(seconds: 1), // Duration of the animation
      vsync: this,
    );

    // Create a Tween to animate the progress value
    _animation = Tween<double>(begin: 0.0, end: progress).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Smooth easing curve
    ));

    // Start the animation when the widget is first built
    _controller.forward();
  }

  @override
  void didUpdateWidget(TemperatureProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.minTemp != widget.minTemp || oldWidget.maxTemp != widget.maxTemp) {
      // Recalculate progress if temperature changes
      progress = getProgressValue(widget.minTemp, widget.maxTemp);
      _controller.reset();
      _animation = Tween<double>(begin: 0.0, end: progress).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double getProgressValue(int minTemp, int maxTemp) {
    // Determine the total temperature range
    int temperatureRange = maxTemp - minTemp;

    // If the range is 0 (same min and max), default to 0.5 for the progress bar
    if (temperatureRange == 0) {
      return 0.5;
    }

    // Normalize the average temperature value between 0 and 1
    double averageTemp = (minTemp + maxTemp) / 2;

    // Assuming a range of 0 to 50°C for simplicity (you can adjust this depending on the expected temp range)
    double normalizedProgress = (averageTemp) / 50.0;

    // Ensure progress stays between 0.0 and 1.0
    return normalizedProgress.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Progress bar with fixed width
          SizedBox(
            width: 50,  // Set the width to 20
            child: LinearProgressIndicator(
              value: _animation.value,
              minHeight: 6.0,
              backgroundColor: Colors.blueGrey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}

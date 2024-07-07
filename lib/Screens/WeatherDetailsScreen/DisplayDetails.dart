import 'package:flutter/material.dart';
import 'LinearGradient.dart';
import 'WeatherModel.dart';

// Widget to display weather details for a specific city
class DisplayData extends StatefulWidget {
  const DisplayData({super.key, required this.searchIt});
  final SearchIt searchIt;

  @override
  State<DisplayData> createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  late SearchIt _weatherData;  // Variable to store the weather data for a city

  // Initialize the state with passed weather data
  @override
  void initState(){
    super.initState();
    _weatherData = widget.searchIt;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // Set the background gradient based on weather condition
        decoration: BoxDecoration(
          gradient: gradientColorDeciding(widget.searchIt.weatherCondition),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20,),
              _details(
                title: "City Name",
                value: widget.searchIt.name,
                icon: Icons.location_city,
              ),
              const SizedBox(height: 20,),
              _details(
                title : "Tempreature",
                value:  '${widget.searchIt.tempCelsius.toStringAsFixed(2)}C',
                icon : Icons.thermostat,
              ),
              const SizedBox(height: 20,),
              _details(
                title: 'Weather Condition',
                value:   widget.searchIt.weatherCondition,
                icon : Icons.wb_cloudy,
              ),
              const SizedBox(height: 20,),
              _details(
                title: 'Humidity',
                value:  '${widget.searchIt.humidity}%',
                icon:  Icons.opacity,
              ),
              const SizedBox(height: 20,),
              _details(
                title: 'Wind Speed',
                value:  '${widget.searchIt.windSpeed}m/s',
                icon:  Icons.air,
              ),
              const SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }

  // Widget to display a weather detail with an icon, label, and value
  Widget _details({
    required String title,
    required String value,
    required IconData? icon,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle( // Styling properties for title
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5,),
            Row(
              children: [
                if(icon != null)...[
                  Icon(
                    icon,
                    color: Colors.grey[600], // Styling properties for icons
                    size: 28,
                  ),
                  const SizedBox(width: 5,),
                  Text(
                    value,
                    style: const TextStyle( // Styling properties for value
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  )
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

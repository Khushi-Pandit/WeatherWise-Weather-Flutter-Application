import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'DisplayDetails.dart';
import 'WeatherModel.dart';

// Widgets to display weather details and handle fetching data again while refreshing
class WeatherDetails extends StatefulWidget {
  const WeatherDetails({super.key, required this.data});
  final SearchIt data;

  @override
  State<WeatherDetails> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  late SearchIt _weatherData  ;  // Variable to store weather data for a city
  bool _isLoading = false;       // Variable to manage loading state

  // Initialize the state with the passed weather data
  @override
  void initState(){
    super.initState();
    _weatherData = widget.data;
  }

  // Function for fetch weather data again for a specified city after refreshing
  void againFetch(String cityName) async {
    setState(() {
      _isLoading = true;
    });
    // URL for fetching the data
    final url = "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=059961011ba0e5108c7751fbd2f125a2";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      // Update weather data with fetched data
      _weatherData =  SearchIt.fromJson(json.decode(response.body)) ;
      setState(() {
        _isLoading = false;
      });
    }else{
      setState(() {
        _isLoading = false;
      });
      showSnackBar("Fail to fetch");
    }
  }

  // Function to show a error message with SnackBar
  void showSnackBar(error){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,  // Setting toolbar height
        title: const Text(
          "WeatherWise",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.transparent, // Make background transparent gradient effect
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              againFetch(_weatherData.name);
            },
          ),
        ],
        centerTitle: true,  // Centering the title
        elevation: 0, // Remove shadow for better visual gradient
      ),
      body: Stack(
        children: [
          DisplayData(searchIt: _weatherData),  // Display the weather data
          (_isLoading) ? _buildLoadingOverlay(context) : Container()   // Show loading overlay if fetching data
        ],
      ),
    );
  }
}

// Widget to build a loading overlay  with a circular progress indicator
Widget _buildLoadingOverlay(BuildContext context) {
  return IgnorePointer(
    ignoring: false, // Allow interactions with underlying widgets
    child: Container(
      color: Colors.black.withOpacity(0.5), // Transparent background
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    ),
  );
}


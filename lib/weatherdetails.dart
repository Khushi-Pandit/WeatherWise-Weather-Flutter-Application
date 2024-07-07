import 'package:firstintern/searchit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherDetails extends StatefulWidget {
  const WeatherDetails({super.key, required this.data});
  final SearchIt data;

  @override
  State<WeatherDetails> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  late SearchIt _weatherData  ;
  bool _isLoading = false;

  @override
  void initState(){
    super.initState();
    _weatherData = widget.data;
  }

  void againFetch(String cityName) async {
    setState(() {
      _isLoading = true;
    });
    final url = "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=059961011ba0e5108c7751fbd2f125a2";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
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
        toolbarHeight: 45,
        title: const Text("WeatherWise", style: TextStyle(color: Colors.black, fontSize: 20),),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              againFetch(_weatherData.name);
            },
          ),
        ],
        centerTitle: true,
        elevation: 0, // Remove shadow for better visual gradient
      ),
      body: Stack(
        children: [
          DisplayData(searchIt: _weatherData),
          (_isLoading) ? _buildLoadingOverlay(context) : Container()
        ],
      ),
    );
  }
}

Widget _buildLoadingOverlay(BuildContext context) {
  return IgnorePointer(
    ignoring: false, // true: prevents interactions with underlying widgets
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


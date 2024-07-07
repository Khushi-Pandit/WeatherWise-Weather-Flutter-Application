// Class representing weather data for the specific city
class SearchIt {
  final String name;               // City name
  final double temp;               // Temperature in Kelvin
  final String weatherCondition;   // Weather condition (e.g., Clouds, Rain)
  final int humidity;              // Humidity percentage
  final double windSpeed;          // Wind speed in m/s

  // Constructor to initialize the weather data for this class
  SearchIt(
      {required this.name,
        required this.temp,
        required this.weatherCondition,
        required this.humidity,
        required this.windSpeed});

  // Factory constructor to create a SearchIt instance from a JSON map
  factory SearchIt.fromJson(Map<String, dynamic> json) {
    return SearchIt(
      name: json["name"],
      temp: json["main"]["temp"],
      weatherCondition: json["weather"][0]["main"],
      humidity: json["main"]["humidity"],
      windSpeed: json["wind"]["speed"],
    );
  }
  // Converting temp from "kelvin" to "celsius"
  double get tempCelsius => (temp - 273.15);
}
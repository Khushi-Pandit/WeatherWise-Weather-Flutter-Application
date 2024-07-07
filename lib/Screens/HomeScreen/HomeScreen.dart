import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../WeatherDetailsScreen/WeatherDetailsScreen.dart';
import '../WeatherDetailsScreen/WeatherModel.dart';

// Screen representing HomeScreen with a search bar and a search button
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {

  // Initializing controllers & variables
  final TextEditingController userInput = TextEditingController();  // Text field Input given by user
  final List<String> _recentItems = [];  // List to store recent search items
  bool _isLoading = false;  // Variable to manage loading state

  // Function to add items/searches (user Input) to the recent items list
  void _addToRecent(String item) {
    setState(() {
      if (!_recentItems.contains(item)) {
        if (item != "") {
          _recentItems.add(item);
          if (_recentItems.length > 3) {  // Keeping list for Top three searches only
            _recentItems.removeAt(0);
          }
        }
      }
    });
  }

  // Fetching to fetch current weather data from OpenWeatherMap API
  void fetchData(input) async {
    if (input != "") {
      setState(() {
        _isLoading = true;  // Display loading indicator while fetching data from API
      });
      final url = "https://api.openweathermap.org/data/2.5/weather?q=$input&appid=059961011ba0e5108c7751fbd2f125a2";
      final response = await http.get(Uri.parse(url));   // Wait until the Url is parsed
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = await jsonDecode(response.body);  // Map the fetched JSON data
        final searchIt = SearchIt.fromJson(jsonData);

        // hideLoadingOverlay(context);
        setState(() {
          _isLoading = false;
        });

        // Navigate to weatherDetails screen with the fetched data
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => WeatherDetails(data: searchIt)));
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar("City not Found");   // Displaying Error message via SnackBar
      }
    } else {
      showSnackBar("Invalid city name");
    }
  }

  // Function to display a SnackBar with an error message
  void showSnackBar(error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              "WeatherWise",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: const Color(0xFFAED5FD),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFAED5FD),
                    Color(0xFFC5E0FE),
                    Color(0xFFF0F7FF),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    SearchBar(context),   // Widget call for Search Bar and search Button

                    const SizedBox(height: 20),

                    RecentSearches(context),   // Widget call for Recent Searches list and displaying it

                    BottomLogo(context),    // Widget call for BottomLogo and text
                  ],
                ),
              ),
            ),
          ),
        ),
        (_isLoading) ? _buildLoadingOverlay(context) : Container(),
      ],
    );
  }

  Widget SearchBar(BuildContext context){
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: userInput,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(
                  Icons.search, color: Color(0xFF64B5F6)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              hintText: "Search for a city",
              hintStyle: TextStyle(color: Colors.grey[500]),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              isDense: true,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: const Color(0xFF42A5F5),
            shadowColor: Colors.black.withOpacity(0.2),
            elevation: 10,
            // backgroundColor: Colors.blueAccent,
          ),
          onPressed: () async {
            final input = userInput.text;
            _addToRecent(input);
            userInput.clear();
            fetchData(input);
          },
          child: const Text("Search",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // Widget for displaying Recent searches
  Widget RecentSearches(BuildContext context){
    return Column(
      children: [
        const Center(
          child: Text(
            "Recent Searches",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.56,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _recentItems.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(vertical: 5),
                elevation: 5,
                shadowColor: Colors.black.withOpacity(0.1),
                child: ListTile(
                  leading: const Icon(Icons.location_city,
                      color: Color(0xFF42A5F5)),
                  title: Text(
                    _recentItems[index],
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Widget for displaying BottomLogo and bottom text
  Widget BottomLogo(BuildContext context){
    return Column(
      children: [
        Image.asset(
          'assets/images/wwlogo.png',
          width: 40,
          height: 40,
        ),
        const SizedBox(height: 7,),
        const Center(
          child: Text("Discover the Weather around you! ",
            style: TextStyle(
              color: Color(0xFF333333),
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  // Widget to build a loading overlay with a circular progress indicator
  Widget _buildLoadingOverlay(BuildContext context) {
    return IgnorePointer(
      ignoring: false, // Allow interactions with inderlying widgets
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

}
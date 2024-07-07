import 'package:flutter/material.dart';

class SearchIt {
  final String name;
  final double temp;
  final String weatherCondition;
  final int humidity;
  final double windSpeed;

  SearchIt(
      {required this.name,
      required this.temp,
      required this.weatherCondition,
      required this.humidity,
      required this.windSpeed});

  factory SearchIt.fromJson(Map<String, dynamic> json) {
    return SearchIt(
      name: json["name"],
      temp: json["main"]["temp"],
      weatherCondition: json["weather"][0]["main"],
      humidity: json["main"]["humidity"],
      windSpeed: json["wind"]["speed"],

    );
  }
  double get tempCelsius => (temp - 273.15);
}


class DisplayData extends StatefulWidget {
  const DisplayData({super.key, required this.searchIt});
  final SearchIt searchIt;

  @override
  State<DisplayData> createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  late SearchIt _weatherData;

  @override
  void initState(){
    super.initState();
    _weatherData = widget.searchIt;
  }
  LinearGradient gradientColorDeciding(String condition) {
    switch (condition) {
      case "Clouds":
        return const LinearGradient(
          colors: [Color(0xFF4A90E2), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case "Haze":
        return const LinearGradient(
          colors: [Color(0xFF757F9A), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case "Rain":
        return const LinearGradient(
          colors: [Color(0xFF005BEA), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case "Clear":
        return const LinearGradient(
          colors: [Color(0xFFFDC830), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      default:
        return const LinearGradient(
          colors: [Color(0xFF36D1DC), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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

  Widget _details({
      required String title,
      required String value,
      required IconData? icon,
  }){
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
              style: const TextStyle(
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
                color: Colors.grey[600],
                size: 28,
              ),
            const SizedBox(width: 5,),
            Text(
              value,
              style: const TextStyle(
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

// Widget build(BuildContext context) {
//   return SingleChildScrollView(
//     child: Container(
//       decoration: BoxDecoration(
//         gradient: gradientColorDeciding(searchIt.weatherCondition),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const SizedBox(height: 50,),
//             _details(
//               title: "City Name",
//               value: searchIt.name,
//               icon: Icons.location_city,
//             ),
//             const SizedBox(height: 20,),
//             _details(
//               title : "Tempreature",
//               value:  '${searchIt.tempCelsius.toStringAsFixed(2)}C',
//               icon : Icons.thermostat,
//             ),
//             const SizedBox(height: 20,),
//             _details(
//               title: 'Weather Condition',
//               value:   searchIt.weatherCondition,
//               icon : Icons.wb_cloudy,
//             ),
//             const SizedBox(height: 20,),
//             _details(
//               title: 'Humidity',
//               value:  '${searchIt.humidity}%',
//               icon:  Icons.opacity,
//             ),
//             const SizedBox(height: 20,),
//             _details(
//               title: 'Wind Speed',
//               value:  '${searchIt.windSpeed}m/s',
//               icon:  Icons.air,
//             ),
//             const SizedBox(height: 20,)
//           ],
//         ),
//       ),
//     ),
//   );
// }


//
// @override
// Widget build(BuildContext context) {
//   return SingleChildScrollView(
//     child: Container(
//       decoration: BoxDecoration(
//         gradient: gradientColorDeciding(searchIt.weatherCondition),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//           Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const SizedBox(width: 5,),
//             Text(searchIt.name,style:
//             const TextStyle(
//               fontSize: 24,
//             ),),
//             const Icon(Icons.refresh),
//           ],
//         ),
//         const SizedBox(height: 10,),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             RichText(
//               text: TextSpan(
//                   style: GoogleFonts.robotoCondensed(
//                     fontSize: 100,
//                     fontWeight: FontWeight.w100,
//                     color: Colors.black, // default text color
//                   ),
//                   children:[
//               TextSpan(
//               text: const '${searchIt.tempCelsius.toStringAsFixed(0)}',
//             ),
//             TextSpan(
//               text: '\u00B0',
//               style: GoogleFonts.roboto(
//                   fontWeight: FontWeight.w100,
//                   color: Colors.black54
//               ),
//             ),
//             TextSpan(
//               text: 'C',
//               style: GoogleFonts.robotoCondensed(
//                 fontWeight: FontWeight.w100,
//                 color: Colors.black54, // different color for 'C'
//               ),
//             ),
//           ],
//         ),
//       ),
//       Column(
//         children: [
//           SizedBox(height: 20,),
//           Text(searchIt.weatherCondition,
//             style: const TextStyle(
//               fontSize: 40,
//             ),
//           ),
//         ],
//       )
//       ],
//     )
//     ],
//   ),
//   ),
//   ),
//   );
// }
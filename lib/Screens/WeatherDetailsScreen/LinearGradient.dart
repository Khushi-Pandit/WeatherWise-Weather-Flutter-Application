import 'package:flutter/material.dart';

// Function to determine the background gradient based on the weather condition
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
    default:   // Default gradient for other cases
      return const LinearGradient(
        colors: [Color(0xFF36D1DC), Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
  }
}
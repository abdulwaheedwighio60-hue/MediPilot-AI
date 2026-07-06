import 'package:flutter/material.dart';

class HomeFeature {
  final String title;
  final String description;
  final IconData icon;
  final List<String> allowedPlans;
  final String requiredPlan;

  HomeFeature({
    required this.title,
    required this.description,
    required this.icon,
    required this.allowedPlans,
    required this.requiredPlan,
  });
}
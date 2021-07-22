import 'dart:math';

import 'package:flutter/material.dart';

class PaintColor {
  String name;
  bool bookmarked = false;
  Color color;
  String type;
  int emissivity;
  int irReflectivity;
  int tempReduction;
  bool isInterior;
  double costPerSqft;

  void toggleBookmark() {
    bookmarked = !bookmarked;
  }

  PaintColor(
    String name,
    Color color,
    String type,
    int emissivity,
    int irReflectivity,
    int tempReduction,
    bool isInterior,
    double costPerSqft,
  ) {
    this.name = name;
    this.color = color;
    this.type = type;
    this.emissivity = emissivity;
    this.irReflectivity = irReflectivity;
    this.tempReduction = tempReduction;
    this.isInterior = isInterior;
    this.costPerSqft = costPerSqft;
  }
}

List<List<PaintColor>> paints = List<List<PaintColor>>.empty(growable: true);
List<String> types = [
  "Cool Paints",
  'Premium Paints',
  'Roof Paints',
  'Interior Paints',
  'Exterior Paints'
];
void initColors() {
  for (int i = 0; i < 5; i++) {
    List<PaintColor> p = List<PaintColor>.empty(growable: true);

    for (int j = 0; j < 5; j++) {
      Color c =
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
      p.add(PaintColor(c.toString(), c, types[i], 0, 0, 0, false,
          Random().nextDouble() * 10));
    }
    paints.add(p);
  }
}

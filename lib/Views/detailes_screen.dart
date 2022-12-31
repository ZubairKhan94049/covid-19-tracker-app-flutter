import 'package:flutter/material.dart';

class DetailesScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases=0, totalDeaths=0, totalRecovered=0,active=0, critical=0,todayRecovered=0, test=0;

  DetailesScreen({
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.todayRecovered,
    required this.critical,
    required this.test,
    required this.image,
  });

  @override
  State<DetailesScreen> createState() => _DetailesScreenState();
}

class _DetailesScreenState extends State<DetailesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
    );
  }
}

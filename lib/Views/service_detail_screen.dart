import 'package:flutter/material.dart';

class ServiceDetailScreen extends StatelessWidget {
  final String serviceTitle;

  const ServiceDetailScreen({Key? key, required this.serviceTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(serviceTitle,style: TextStyle(fontFamily: 'Syne'),),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'You tapped on: $serviceTitle',
          style: TextStyle(fontSize: 18,fontFamily: 'Syne'),
        ),
      ),
    );
  }
}

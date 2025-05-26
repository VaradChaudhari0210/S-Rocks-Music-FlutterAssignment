import 'package:flutter/material.dart';
import '../models/service_model.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;

  const ServiceCard({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          //setting up background image
          image: DecorationImage(
            image: AssetImage(service.backgroundImagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8),
              BlendMode.darken,
            ),
          )
      ),
      child: Row(
        children: [
          Image(image: AssetImage(service.iconPath)),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service.title, style: TextStyle(fontSize: 15, fontFamily: 'Syne',fontWeight: FontWeight.w700)),
                Text(service.description, style: TextStyle(fontSize: 13,fontFamily: 'Syne',fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
        ],
      ),
    );
  }
}

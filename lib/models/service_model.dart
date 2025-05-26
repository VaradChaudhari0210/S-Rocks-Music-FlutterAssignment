import 'package:cloud_firestore/cloud_firestore.dart';

//Model class for Different Services provided by the application
class ServiceModel {
  final String id;
  final String title;
  final String description;
  final String iconPath;
  final String backgroundImagePath;

  ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.backgroundImagePath
  });

  // Factory constructor to create a ServiceModel from a Firestore document
  factory ServiceModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ServiceModel(
        id: doc.id,
        title: data['title'] ?? 'No Title',
        description: data['description'] ?? 'No Description',
        iconPath: data['iconPath'],
        backgroundImagePath: data['backgroundImagePath']
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/service_model.dart';

// Provider for FirebaseFirestore instance
final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

// Repository for fetching services
class ServicesRepository {
  final FirebaseFirestore _firestore;

  ServicesRepository(this._firestore);

  Future<List<ServiceModel>> fetchServices() async {
    try {
      QuerySnapshot querySnapshot =
      await _firestore.collection('Services').get();
      return querySnapshot.docs
          .map((doc) => ServiceModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching services in repository: $e');
      throw Exception('Failed to fetch services: $e');
    }
  }
}

// Provider for ServicesRepository
final servicesRepositoryProvider = Provider<ServicesRepository>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return ServicesRepository(firestore);
});

// This provider will automatically handle loading, data, and error states for the asynchronous operation of fetching services.
final servicesProvider = FutureProvider<List<ServiceModel>>((ref) async {
  final servicesRepository = ref.watch(servicesRepositoryProvider);
  return servicesRepository.fetchServices();
});

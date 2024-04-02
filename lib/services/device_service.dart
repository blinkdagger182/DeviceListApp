// services/device_service.dart
import 'dart:convert';
import 'package:authentication/model/device_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

class DeviceService {
  Future<void> updateDevice(DatabaseReference _dbRef, Device device,
      Map<String, dynamic> data) async {
    _dbRef.child(device!.key!).update(data).then((value) {});
  }

  Future<void> addDevice(DatabaseReference _dbRef, Device device,
      Map<String, dynamic> data) async {
    _dbRef.push().set(data).then((value) {});
  }

  Future<void> deleteDevice(DatabaseReference _dbRef, Device device) async {
    _dbRef.child(device.key!).remove().then((value) {});
  }
}

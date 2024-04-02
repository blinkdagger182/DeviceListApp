import 'package:authentication/services/data_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../services/device_service.dart';
import '../model/device_model.dart';

class DeviceViewModel extends ChangeNotifier {
  List<Device> devicesList = [];
  final DeviceService _deviceService = DeviceService();
  final DataService _dataService = DataService();
  List<Device> returnDeviceData() {
    return devicesList;
  }

  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('');

  Future<void> fetchDevices({int limit = 10, int offset = 0}) async {
    try {
      devicesList.clear(); // Clear the list before adding new devices

      // Fetch devices with limit and offset
      final dataSnapshot = await _dbRef
          .child("devices")
          .orderByKey()
          .limitToFirst(limit)
          .startAt(offset.toString())
          .once(); // Fetch data once

      // Loop through the fetched data and add devices to the list
      _dbRef.child("devices").limitToFirst(limit).onChildAdded.listen((event) {
        final dynamic data = event.snapshot.value;
        final Device device = Device(
          key: event.snapshot.key,
          deviceData: DeviceData.fromJson(data),
        );
        devicesList.add(device);
        notifyListeners();
      });
    } catch (e) {
      print('Error fetching devices: $e');
    }
  }

  Future<void> addDevice(DatabaseReference _dbRef, Device device,
      Map<String, dynamic> data) async {
    try {
      await _deviceService.addDevice(_dbRef, device, data);
      // devices.add(device);
      notifyListeners();
    } catch (e) {
      print('Error adding device: $e');
    }
  }

  Future<void> updateDevice(DatabaseReference _dbRef, Device device,
      Map<String, dynamic> data) async {
    try {
      await _deviceService.updateDevice(_dbRef, device, data);
      notifyListeners();
    } catch (e) {
      print('Error updating device: $e');
    }
  }

  Future<void> deleteDevice(index) async {
    try {
      await _dataService.deleteDevice(index);
      devicesList.removeWhere((d) => d.key == index);
      // _dbRef.child(index.toString()).remove();
      notifyListeners();
    } catch (e) {
      print('Error deleting device: $e');
    }
  }
}

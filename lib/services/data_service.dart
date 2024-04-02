import 'package:firebase_database/firebase_database.dart';

class DataService {
  // final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('devices');
  Future<void> createDevice(
      String deviceName, String variant, String IMEI) async {
    final newDeviceRef = _dbRef.push();
    await newDeviceRef.set({
      // Use newDeviceRef instead of _dbRef
      'device_name': deviceName,
      'variant': variant,
      'IMEI_Serial': IMEI,
    });
  }

  Future<void> updateDevice(
      String deviceId, String deviceName, String variant, String IMEI) async {
    final deviceRef = _dbRef.child(deviceId); // Use deviceRef instead of _dbRef
    await deviceRef.update({
      // Use deviceRef instead of _dbRef
      'device_name': deviceName,
      'variant': variant,
      'IMEI_Serial': IMEI,
    });
  }

  Future<void> deleteDevice(String deviceId) async {
    final deviceRef = await _dbRef.child(deviceId).remove();
    deviceRef;
    // await deviceRef.remove();
  }
}

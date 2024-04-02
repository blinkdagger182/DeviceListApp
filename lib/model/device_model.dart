import 'dart:convert';

class Device {
  String? key;
  DeviceData? deviceData;

  Device({this.key, this.deviceData});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      key: json['key'],
      deviceData: DeviceData.fromJson(json['deviceData']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'deviceData': deviceData?.toJson(),
    };
  }
}

class DeviceData {
  final int id;
  final String deviceName;
  final String variant;
  final String imeiSerial;
  final String url;

  DeviceData({
    required this.id,
    required this.deviceName,
    required this.variant,
    required this.imeiSerial,
    required this.url,
  });

  factory DeviceData.fromJson(Map<dynamic, dynamic> json) {
    return DeviceData(
      id: json['id'] ?? 0, // Providing a default value of 0 if 'id' is missing
      deviceName: json['device_name'] ??
          "", // Providing an empty string if 'device_name' is missing
      variant: json['variant'] ??
          "", // Providing an empty string if 'variant' is missing
      imeiSerial: json['IMEI_Serial'] ??
          "", // Providing an empty string if 'IMEI_Serial' is missing
      url: json['url'] ??
          "", // Providing an empty string if 'IMEI_Serial' is missing
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'device_name': deviceName,
      'variant': variant,
      'IMEI_Serial': imeiSerial,
      'url': url,
    };
  }
}

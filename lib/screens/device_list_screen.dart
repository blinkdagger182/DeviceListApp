import 'package:authentication/model/device_model.dart';
import 'package:authentication/services/data_service.dart';
import 'package:authentication/viewmodel/device_viewmodel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class DeviceListScreen extends StatefulWidget {
  @override
  State<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  final TextEditingController _deviceNameController = TextEditingController();
  final TextEditingController _variantNameController = TextEditingController();
  final TextEditingController _imeiSerialController = TextEditingController();

  late DatabaseReference _dbRef;
  late ScrollController _scrollController;
  bool _isLoading = false;
  int _limit = 50;
  int _offset = 0;

  @override
  void initState() {
    super.initState();
    _dbRef = FirebaseDatabase.instance.ref().child('devices');
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    // Fetch devices when the widget initializes
    _fetchDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome!',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                deviceDialog(context);
              },
              child: Row(
                children: [
                  Text('Add Devices', style: TextStyle(fontFamily: 'Poppins')),
                  Icon(
                    Icons.add,
                    size: 26.0,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Consumer<DeviceViewModel>(
        builder: (context, viewModel, _) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 300,
              crossAxisCount: 2, // Number of columns in the grid
              crossAxisSpacing: 8.0, // Spacing between columns
              mainAxisSpacing: 8.0, // Spacing between rows
              childAspectRatio: 1, // Aspect ratio for square cards
            ),
            itemCount: viewModel.devicesList.length,
            itemBuilder: (context, index) {
              final device = viewModel.devicesList[index];
              return Card(
                elevation: 1,
                color: Colors.white,
                child: GestureDetector(
                  onTap: () {
                    _showDeviceDetailsModal(context, device);
                  },
                  child: GridTile(
                    footer: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            device.deviceData!.deviceName,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontFamily: 'Poppins'),
                          ),
                          Text(
                            device.deviceData!.variant,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: <Widget>[
                        const Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.lightBlue),
                          ),
                        ),
                        if (device.deviceData!.url.isNotEmpty)
                          Center(
                            child: FadeInImage.memoryNetwork(
                              fit: BoxFit
                                  .contain, // Uncomment this line if needed
                              placeholder: kTransparentImage,
                              image: device.deviceData!.url,
                            ),
                          )
                        else
                          Center(
                            child: Image.asset(
                              'assets/images/image_error.jpeg', // Default image path
                              // You can adjust the fit property if needed
                              fit: BoxFit.cover,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void deviceDialog(BuildContext context, [Device? device]) {
    final viewModel = Provider.of<DeviceViewModel>(context, listen: false);
    final isEditing = device != null;
    _deviceNameController.text =
        isEditing ? device!.deviceData!.deviceName : '';
    _variantNameController.text = isEditing ? device!.deviceData!.variant : '';
    _imeiSerialController.text =
        isEditing ? device!.deviceData!.imeiSerial : '';

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // SizedBox(
                //     height: 200,
                //     child: device!.deviceData!.url.isNotEmpty
                //         ? Image.network(
                //             device.deviceData!.url,
                //             fit: BoxFit.cover,
                //           )
                //         : Image.asset(
                //             'assets/images/image_error.jpeg', // Default image path
                //             fit: BoxFit.cover,
                //           )),
                TextField(
                  style: TextStyle(
                      fontSize: 12, color: Colors.black, fontFamily: 'Poppins'),
                  controller: _deviceNameController,
                  decoration: InputDecoration(
                    helperText: "Device Name",
                  ),
                ),
                TextField(
                  style: TextStyle(
                      fontSize: 12, color: Colors.black, fontFamily: 'Poppins'),
                  controller: _variantNameController,
                  decoration: InputDecoration(helperText: "Variant"),
                ),
                TextField(
                  style: TextStyle(
                      fontSize: 12, color: Colors.black, fontFamily: 'Poppins'),
                  controller: _imeiSerialController,
                  decoration: InputDecoration(helperText: "IMEI Serial"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    Map<String, dynamic> data = {
                      "device_name": _deviceNameController.text,
                      "variant": _variantNameController.text,
                      "IMEI_Serial": _imeiSerialController.text,
                      "id": 2
                    };

                    if (isEditing) {
                      await viewModel.updateDevice(_dbRef, device, data);

                      Navigator.of(context).pop();
                      _fetchDevices();
                    } else {
                      _dbRef.push().set(data).then((value) {
                        Navigator.of(context).pop();
                        _fetchDevices();
                      });
                    }
                  },
                  child: Text(isEditing ? 'Update' : 'Add'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeviceDetailsModal(BuildContext context, Device device) {
    final viewModel = Provider.of<DeviceViewModel>(context, listen: false);

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                  height: 200,
                  child: device.deviceData!.url.isNotEmpty
                      ? Image.network(
                          device.deviceData!.url,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/image_error.jpeg', // Default image path
                          fit: BoxFit.cover,
                        )),
              SizedBox(height: 16.0),
              Text('Device Name: ${device.deviceData!.deviceName}',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontFamily: 'Poppins')),
              SizedBox(height: 8.0),
              Text('Variant: ${device.deviceData!.variant}',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontFamily: 'Poppins')),
              SizedBox(height: 8.0),
              Text('IMEI Serial: ${device.deviceData!.imeiSerial}',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontFamily: 'Poppins')),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      deviceDialog(context, device);
                    },
                    child: Text('Edit'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _deleteDevice(device);
                    },
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteDevice(Device device) {
    _dbRef.child(device.key!).remove().then((value) {
      Provider.of<DeviceViewModel>(context, listen: false)
          .deleteDevice(device.key!);
    });
  }

  void _fetchDevices() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<DeviceViewModel>(context, listen: false)
          .fetchDevices(limit: _limit, offset: _offset)
          .then((_) {
        setState(() {
          _isLoading = false;
          _offset += _limit;
        });
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading) {
      _fetchDevices();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

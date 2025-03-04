import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:sensor_tree/Classes/Utils/utils.dart';
import 'package:flutter_ble_peripheral/flutter_ble_peripheral.dart';

class BluetoothListScreen extends StatefulWidget {
  const BluetoothListScreen({super.key});

  @override
  State<BluetoothListScreen> createState() => _BluetoothListScreenState();
}

class _BluetoothListScreenState extends State<BluetoothListScreen> {
  final FlutterBlePeripheral blePeripheral = FlutterBlePeripheral();
  final AdvertiseData advertiseData = AdvertiseData(
    includeDeviceName: true,
    localName: "My Custom Device", // Set your custom name here
    manufacturerId: 0x1234, // Example manufacturer ID
    manufacturerData: Uint8List.fromList([1, 2, 3, 4]),
  );

  List<ScanResult> scanResults = [];
  List<BluetoothDevice> connectedDevices = [];

  @override
  void initState() {
    super.initState();
    startScan();
    checkConnectedDevices();
    adver();
  }

  void adver() async {
    await Future.delayed(Duration(milliseconds: 400));
    startAdvertising(); // Start advertising so others can detect this device
  }

  void startAdvertising() async {
    bool isSupported = await blePeripheral.isSupported;
    if (isSupported) {
      await blePeripheral.start(
        advertiseData: advertiseData,
      ); // Use named argument
      customLog("Started Advertising as: My Custom Device");
    } else {
      customLog("Advertising not supported on this device");
    }
  }

  void stopAdvertising() async {
    await blePeripheral.stop();
    customLog("Stopped Advertising");
  }

  void startScan() {
    scanResults.clear(); // Clear previous results
    FlutterBluePlus.startScan(timeout: Duration(seconds: 10));

    FlutterBluePlus.scanResults.listen((results) {
      if (!mounted) return; // ✅ Prevent setState if widget is disposed
      setState(() {
        scanResults = results;
      });
      // customLog(scanResults);
    });
  }

  void stopScan() {
    FlutterBluePlus.stopScan();
  }

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
    stopAdvertising(); // Stop advertising when screen is disposed
    super.dispose();
  }

  /// Check already connected devices
  void checkConnectedDevices() async {
    List<BluetoothDevice> devices = FlutterBluePlus.connectedDevices;
    setState(() {
      connectedDevices = devices;
    });
    customLog("Connected devices: $connectedDevices");
  }

  /// Connect to a selected device
  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      await Future.delayed(Duration(seconds: 2)); // Wait for the name update

      setState(() {
        if (!connectedDevices.contains(device)) {
          connectedDevices.add(device);
        }
      });

      customLog("Connected to: ${device.name}");
    } catch (e) {
      customLog("Error connecting: $e");
    }
  }

  /// Disconnect from a device
  Future<void> disconnectFromDevice(BluetoothDevice device) async {
    try {
      await device.disconnect();
      setState(() {
        connectedDevices.remove(device);
      });
    } catch (e) {
      customLog("Error disconnecting: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bluetooth Devices")),
      body: Column(
        children: [
          // Button to Start Scanning
          ElevatedButton(onPressed: startScan, child: Text("Search Again")),

          // List of Connected Devices
          if (connectedDevices.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Connected Devices",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: connectedDevices.length,
                itemBuilder: (context, index) {
                  final device = connectedDevices[index];
                  return ListTile(
                    title: Text(
                      device.name.isNotEmpty ? device.name : "Unknown Device",
                    ),
                    subtitle: Text(device.id.toString()),
                    trailing: ElevatedButton(
                      onPressed: () => disconnectFromDevice(device),
                      child: Text("Disconnect"),
                    ),
                  );
                },
              ),
            ),
          ],

          // List of Scanned Devices
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Available Devices",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: scanResults.length,
              itemBuilder: (context, index) {
                final result = scanResults[index];
                final device = result.device;
                final deviceName =
                    result.advertisementData.localName.isNotEmpty
                        ? result.advertisementData.localName
                        : (device.name.isNotEmpty
                            ? device.name
                            : "Unknown Device");

                return ListTile(
                  title: Text(deviceName),
                  subtitle: Text(device.id.toString()),
                  trailing: ElevatedButton(
                    onPressed: () => connectToDevice(device),
                    child: Text("Connect"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

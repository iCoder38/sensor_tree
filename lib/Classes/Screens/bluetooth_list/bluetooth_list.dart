import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sensor_tree/Classes/Utils/utils.dart';

class BluetoothScannerScreen extends StatefulWidget {
  const BluetoothScannerScreen({super.key});

  @override
  State<BluetoothScannerScreen> createState() => _BluetoothScannerScreenState();
}

class _BluetoothScannerScreenState extends State<BluetoothScannerScreen> {
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  final List<DiscoveredDevice> _devices = [];
  StreamSubscription<DiscoveredDevice>? _scanSubscription;
  bool _isScanning = false;
  String _status = 'Press Search to begin';
  String _error = '';

  @override
  void initState() {
    super.initState();
    _checkLocationServices();
    return;
    _requestPermissions();
    _checkBluetoothStatus();
  }

  Future<void> _checkLocationServices() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        customLog('Please enable GPS (location services).');
        _error = 'Please enable GPS (location services).';
      });
      await Geolocator.openLocationSettings();
    } else {
      customLog("ENABLED");
    }
  }

  Future<void> _requestPermissions() async {
    customLog("YES");
    final status =
        await [
          Permission.locationWhenInUse, // Location permission
          Permission.bluetoothScan, // Bluetooth scan permission
          Permission.bluetoothConnect, // Bluetooth connect permission
        ].request();

    // Check if the status of each permission is denied and handle accordingly
    if (status[Permission.locationWhenInUse] != null &&
        status[Permission.locationWhenInUse]!.isDenied) {
      setState(() {
        _error = 'Location permission not granted.';
      });
      // If location is denied, guide the user to settings
      openAppSettings();
    }

    if (status[Permission.bluetoothScan] != null &&
        status[Permission.bluetoothScan]!.isDenied) {
      setState(() {
        _error = 'Bluetooth scan permission not granted.';
      });
    }

    if (status[Permission.bluetoothConnect] != null &&
        status[Permission.bluetoothConnect]!.isDenied) {
      setState(() {
        _error = 'Bluetooth connect permission not granted.';
      });
    }
  }

  Future<void> _checkBluetoothStatus() async {
    final status = await _ble.status;
    log("BLE status: $status");

    if (status == BleStatus.ready) {
      setState(() {
        _status = 'Bluetooth is ready';
      });
    } else {
      setState(() {
        _error = 'Bluetooth not ready: $status';
      });
    }
  }

  Future<bool> _preparePermissionsAndGPS() async {
    final permissions =
        await [
          Permission.bluetoothScan,
          Permission.bluetoothConnect,
          Permission.location,
          Permission.locationAlways,
          Permission.locationWhenInUse,
        ].request();

    if (permissions.values.any((p) => !p.isGranted)) {
      setState(() {
        _error = 'Permissions not granted';
      });
      if (permissions[Permission.locationWhenInUse]?.isDenied ?? false) {
        // Ask user to enable Location Services
        await openAppSettings();
      }
      return false;
    }

    final gpsEnabled = await Geolocator.isLocationServiceEnabled();
    if (!gpsEnabled) {
      setState(() {
        _error = 'Please enable GPS (location services)';
      });
      await Geolocator.openLocationSettings();
      return false;
    }

    return true;
  }

  void _startScan() async {
    if (_isScanning) {
      _scanSubscription?.cancel();
      setState(() {
        _isScanning = false;
        _status = 'Scan stopped';
      });
      return;
    }

    final ready = await _preparePermissionsAndGPS();
    if (!ready) return;

    setState(() {
      _devices.clear();
      _isScanning = true;
      _status = 'Scanning...';
      _error = '';
    });

    _scanSubscription = _ble
        .scanForDevices(
          withServices: [], // no filter
          scanMode: ScanMode.lowLatency,
        )
        .listen(
          (device) {
            log('Found: ${device.name} (${device.id})');

            if (device.name.isNotEmpty &&
                !_devices.any((d) => d.id == device.id)) {
              setState(() {
                _devices.add(device);
              });
            }
          },
          onError: (e) {
            setState(() {
              _isScanning = false;
              _error = 'Scan error: $e';
            });
          },
        );

    // Stop scan after 15 seconds
    Future.delayed(const Duration(seconds: 15), () {
      if (_isScanning) {
        _scanSubscription?.cancel();
        setState(() {
          _isScanning = false;
          _status = 'Scan complete';
        });
      }
    });
  }

  @override
  void dispose() {
    _scanSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BLE Scanner')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _startScan,
              child: Text(_isScanning ? 'Stop Scan' : 'Search Nearby Devices'),
            ),
            const SizedBox(height: 12),
            Text(_status, style: Theme.of(context).textTheme.bodyLarge),
            if (_error.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                _error,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
            ],
            const Divider(height: 32),
            Expanded(
              child:
                  _devices.isEmpty
                      ? Center(
                        child: Text(
                          _isScanning ? 'Scanning...' : 'No devices found',
                        ),
                      )
                      : ListView.builder(
                        itemCount: _devices.length,
                        itemBuilder: (context, index) {
                          final d = _devices[index];
                          return ListTile(
                            leading: const Icon(Icons.bluetooth),
                            title: Text(d.name),
                            subtitle: Text('ID: ${d.id}\nRSSI: ${d.rssi}'),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

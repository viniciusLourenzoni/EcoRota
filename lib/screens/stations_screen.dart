import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../widgets/location_map.dart';
import '../widgets/nearby_stations.dart';

class StationsScreen extends StatefulWidget {
  const StationsScreen({super.key});

  @override
  State<StationsScreen> createState() => _StationsScreenState();
}

class _StationsScreenState extends State<StationsScreen> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition();
        setState(() {
          _currentPosition = position;
        });
      }
    } catch (e) {
      debugPrint('Erro ao obter localização: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_currentPosition != null) ...[
          Expanded(
            flex: 2,
            child: LocationMap(position: _currentPosition!),
          ),
          Expanded(
            flex: 1,
            child: NearbyStations(position: _currentPosition!),
          ),
        ] else
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
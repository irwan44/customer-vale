import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:customer_bengkelly/app/componen/color.dart';
import '../../../data/data_endpoint/lokasi.dart' as LokasiEndpoint;
import '../../../data/endpoint.dart';

class LokasiBengkelly extends StatefulWidget {
  const LokasiBengkelly({super.key});

  @override
  State<LokasiBengkelly> createState() => _LokasiBengkellyState();
}

class _LokasiBengkellyState extends State<LokasiBengkelly> {
  late GoogleMapController _controller;
  Position? _currentPosition;
  List<Marker> _markers = [];
  List<LokasiEndpoint.DataLokasi> _locationData = [];
  final PanelController _panelController = PanelController();
  String _currentAddress = 'Mengambil lokasi...';
  BitmapDescriptor? _customIcon;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    _loadCustomIcon();
  }

  Future<void> _loadCustomIcon() async {
    _customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      'assets/icons/drop.png', // Path to your custom marker image
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print('Current position: $_currentPosition');
      _getAddressFromLatLng();
      setState(() {});
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.locality}, ${place.subAdministrativeArea}";
      });
    } catch (e) {
      print('Error getting address: $e');
    }
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.location.status;
    print('Permission status: $status');
    if (status.isGranted) {
      print('Permission already granted');
      await _getCurrentLocation();
      await _fetchLocations();
    } else {
      var requestedStatus = await Permission.location.request();
      print('Requested permission status: $requestedStatus');
      if (requestedStatus.isGranted) {
        print('Permission granted');
        await _getCurrentLocation();
        await _fetchLocations();
      } else {
        print('Permission denied');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Permission denied'),
        ));
      }
    }
  }

  Future<void> _fetchLocations() async {
    try {
      final lokasi = await API.LokasiBengkellyID();
      if (lokasi.data != null && _currentPosition != null) {
        _locationData = lokasi.data!;
        for (var data in lokasi.data!) {
          final location = data.geometry?.location;
          if (location != null && location.lat != null && location.lng != null) {
            print('Fetched location: lat=${location.lat}, lng=${location.lng}');
            final latLng = LatLng(double.parse(location.lat!), double.parse(location.lng!));
            final distance = _calculateDistance(
              _currentPosition!.latitude,
              _currentPosition!.longitude,
              latLng.latitude,
              latLng.longitude,
            );
            final travelTime = _calculateTravelTime(distance); // Calculate travel time
            print('Adding marker at: $latLng');
            _markers.add(
              Marker(
                markerId: MarkerId(location.id.toString()),
                position: latLng,
                icon: _customIcon ?? BitmapDescriptor.defaultMarker,
                infoWindow: InfoWindow(
                  title: data.name,
                  snippet: 'Jarak: ${distance.toStringAsFixed(2)} km\nWaktu tempuh: ${travelTime.toStringAsFixed(0)} min',
                ),
              ),
            );
          }
        }
        setState(() {});
      } else {
        print('Failed to fetch locations or current position is null');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to fetch locations or current position is null'),
        ));
      }
    } catch (e) {
      print('Error fetching locations: $e');
    }
  }

  double _calculateDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude) / 1000;
  }

  double _calculateTravelTime(double distance) {
    const averageSpeed = 50.0; // Average speed in km/h
    return (distance / averageSpeed) * 60; // Convert hours to minutes
  }

  void _moveCamera(double lat, double lng) {
    _controller.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(lat, lng),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
        title: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Lokasi Saat ini', style: GoogleFonts.nunito(fontSize: 12)),
                Text(_currentAddress, style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ),
      body: _currentPosition == null
          ? Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: MyColors.appPrimaryColor,
          ),
          SizedBox(height: 10,),
          Text('Sedang memuat lokasi...')
        ],)
      )
          : Stack(
        children: [
          GoogleMap(
            mapType: MapType.terrain,
            zoomGesturesEnabled: true,
            mapToolbarEnabled: true,
            compassEnabled: true,
            zoomControlsEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (controller) {
              _controller = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
              zoom: 14,
            ),
            markers: Set<Marker>.of(_markers),
            padding: EdgeInsets.only(bottom: 240), // Tambahkan padding di sini
          ),
          SlidingUpPanel(
            controller: _panelController,
            panel: _buildSlidingPanel(),
            minHeight: 230,
            maxHeight: MediaQuery.of(context).size.height * 0.7,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            parallaxEnabled: true,
            parallaxOffset: 0.5,
          ),
        ],
      ),
    );
  }

  Widget _buildSlidingPanel() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          height: 5,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _locationData.length,
            itemBuilder: (context, index) {
              final data = _locationData[index];
              final location = data.geometry?.location;
              final distance = _calculateDistance(
                _currentPosition!.latitude,
                _currentPosition!.longitude,
                double.parse(location!.lat!),
                double.parse(location.lng!),
              );
              final travelTime = _calculateTravelTime(distance); // Calculate travel time

              return ListTile(
                title: Text(data.name ?? 'Unknown', style: GoogleFonts.nunito(fontWeight: FontWeight.bold),),
                subtitle: Text(data.vicinity ?? 'Unknown'),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Image.asset(
                        'assets/icons/drop.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('${distance.toStringAsFixed(2)} km'),
                    Text('${travelTime.toStringAsFixed(0)} min'), // Display travel time
                  ],
                ),
                onTap: () {
                  _moveCamera(
                    double.parse(location.lat!),
                    double.parse(location.lng!),
                  );
                  _panelController.close(); // Tutup panel setelah item dipilih
                },
              );
            },
          ),
        ),
      ],
    );
  }

}

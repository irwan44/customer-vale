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
import '../../../data/data_endpoint/lokasilistrik.dart';
import '../../../data/endpoint.dart';

class LokasiListrik1 extends StatefulWidget {
  const LokasiListrik1({super.key});

  @override
  State<LokasiListrik1> createState() => _LokasiListrik1State();
}

class _LokasiListrik1State extends State<LokasiListrik1> {
  late GoogleMapController _controller;
  Position? _currentPosition;
  List<Marker> _markers = [];
  List<DatachargingStation> _locationData = [];
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
      'assets/icons/dropcar2.png',
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
      final lokasi = await API.LokasiListrikID();
      if (lokasi.datachargingStation != null && _currentPosition != null) {
        _locationData = lokasi.datachargingStation!;
        for (var data in lokasi.datachargingStation!) {
          final location = data.geometry?.location;
          if (location != null && location.lat != null && location.lng != null) {
            final lat = double.tryParse(location.lat!);
            final lng = double.tryParse(location.lng!);
            if (lat != null && lng != null) {
              _addMarker(lat, lng, data);
            } else {
              print('Invalid lat/lng values: lat=${location.lat}, lng=${location.lng}');
              _addFallbackMarker(data);
            }
          } else {
            print('Null lat/lng: lat=${location?.lat}, lng=${location?.lng}');
            _addFallbackMarker(data);
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

  void _addMarker(double lat, double lng, DatachargingStation data) {
    final latLng = LatLng(lat, lng);
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
        markerId: MarkerId('${data.name}'),
        position: latLng,
        icon: _customIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: data.name,
          snippet: 'Jarak: ${distance.toStringAsFixed(2)} km\nWaktu tempuh: ${travelTime.toStringAsFixed(0)} min',
        ),
      ),
    );
  }

  void _addFallbackMarker(DatachargingStation data) {
    final latLng = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
    print('Adding fallback marker at: $latLng');
    _markers.add(
      Marker(
        markerId: MarkerId('${data.name}'),
        position: latLng,
        icon: _customIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: data.name,
          snippet: 'Invalid coordinates provided',
        ),
      ),
    );
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
          ? Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: MyColors.appPrimaryColor,
            ),
            SizedBox(height: 10),
            Text('Sedang memuat lokasi...'),
          ],
        ),
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
              setState(() {
                _markers.forEach((marker) {
                  print('Marker added to map: ${marker.markerId}');
                });
              });
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
              final lat = location?.lat != null ? double.tryParse(location!.lat!) : null;
              final lng = location?.lng != null ? double.tryParse(location!.lng!) : null;
              if (lat != null && lng != null) {
                final distance = _calculateDistance(
                  _currentPosition!.latitude,
                  _currentPosition!.longitude,
                  lat,
                  lng,
                );
                final travelTime = _calculateTravelTime(distance);

                return ListTile(
                  title: Text(data.name ?? 'Unknown', style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: MyColors.bgform,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Tegangan Recharge Stasiun ', style: GoogleFonts.nunito(fontWeight: FontWeight.normal)),
                        SizedBox(height: 10,),
                          Text(data.power ?? 'Unknown', style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                      ],),),]),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Image.asset(
                          'assets/icons/dropcar2.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('${distance.toStringAsFixed(2)} km'),
                      Text('${travelTime.toStringAsFixed(0)} min'),
                    ],
                  ),
                  onTap: () {
                    _moveCamera(lat, lng);
                    _panelController.close();
                  },
                );
              } else {
                print('Invalid lat/lng values in ListView: lat=${location?.lat}, lng=${location?.lng}');
                return ListTile(
                  title: Text(data.name ?? 'Unknown', style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                  subtitle: Text('Invalid coordinates'),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

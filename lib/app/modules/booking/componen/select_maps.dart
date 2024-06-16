import 'package:customer_bengkelly/app/componen/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../controllers/booking_controller.dart';

class SelectBooking extends StatelessWidget {
  final BookingController _bookingController = Get.put(BookingController());

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
        title: Obx(() {
          return Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Lokasi Saat ini', style: GoogleFonts.nunito(fontSize: 12)),
                  Text(_bookingController.currentAddress.value, style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          );
        }),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Obx(() {
        if (_bookingController.currentPosition.value == null) {
          return Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: MyColors.appPrimaryColor,
              ),
              SizedBox(height: 10,),
              Text('Sedang memuat lokasi...')
            ],)
          );
        } else {
          return Stack(
            children: [
              GoogleMap(
                mapType: MapType.terrain,
                zoomGesturesEnabled: true,
                mapToolbarEnabled: true,
                compassEnabled: true,
                zoomControlsEnabled: true,
                myLocationButtonEnabled: true,
                onMapCreated: (controller) {
                  _bookingController.mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    _bookingController.currentPosition.value!.latitude,
                    _bookingController.currentPosition.value!.longitude,
                  ),
                  zoom: 14,
                ),
                markers: Set<Marker>.of(_bookingController.markers),
                padding: EdgeInsets.only(bottom: 240),
              ),
              SlidingUpPanel(
                controller: _bookingController.panelController,
                panel: _buildSlidingPanel(),
                minHeight: 230,
                maxHeight: MediaQuery.of(context).size.height * 0.7,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                parallaxEnabled: true,
                parallaxOffset: 0.5,
              ),
            ],
          );
        }
      }),
    );
  }

  Widget _buildSlidingPanel() {
    return Obx(() {
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
              itemCount: _bookingController.locationData.length,
              itemBuilder: (context, index) {
                final data = _bookingController.locationData[index];
                final location = data.geometry?.location;
                final distance = _bookingController.calculateDistance(
                  _bookingController.currentPosition.value!.latitude,
                  _bookingController.currentPosition.value!.longitude,
                  double.parse(location!.lat!),
                  double.parse(location.lng!),
                );

                return ListTile(
                  title: Text(data.name ?? 'Unknown', style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                  subtitle: Text(data.vicinity ?? 'Unknown'),
                  trailing: Column(
                    children: [
                      Icon(Icons.map_sharp),
                      SizedBox(height: 10),
                      Text('${distance.toStringAsFixed(2)} km'),
                    ],
                  ),
                  onTap: () {
                    _bookingController.selectLocation(data);
                    Navigator.pop(context, data.name); // Kembalikan nama lokasi ke halaman pertama
                  },
                );
              },
            ),
          ),
        ],
      );
    });
  }
}

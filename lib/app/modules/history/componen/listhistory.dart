import 'package:customer_bengkelly/app/componen/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/data_endpoint/history.dart';
import '../../../data/endpoint.dart';

class ListHistory extends StatelessWidget {
  final DataHis booking;
  final VoidCallback onTap;
  const ListHistory({super.key, required this.booking, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color statusColor = StatusColor.getColor(booking.namaStatus ?? '');

    // Mapping namaCabang to corresponding image assets
    Map<String, String> cabangImageAssets = {
      'Bengkelly Rest Area KM 379A': 'assets/logo/logo_vale.png',
      'Bengkelly Rest Area KM 228A': 'assets/logo/logo_vale.png',
      'Bengkelly Rest Area KM 389B': 'assets/logo/logo_vale.png',
      'Bengkelly Rest Area KM 575B': 'assets/logo/logo_vale.png',
      'Bengkelly Rest Area KM 319B': 'assets/logo/logo_vale.png',
    };

    // Default image if namaCabang does not match any key
    String imageAsset = cabangImageAssets[booking.namaCabang] ?? 'assets/logo/logo_vale.png';

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${booking.id}',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          color: Colors.transparent,),
                    ),
                    Text(
                      '${booking.namaJenissvc}',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Row(children: [
                       Text(
                        'No Polisi :',
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                        const SizedBox(width: 10,),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child:
                      Text(
                        '${booking.noPolisi}',
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.normal, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: statusColor,
                  ),
                  child: Text(
                    '${booking.namaStatus}',
                    style: GoogleFonts.nunito(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                ClipOval(
                  child:  Image.asset(
                    imageAsset,
                    fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${booking.namaCabang}',
                      style: GoogleFonts.nunito(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 280,
                      child:
                    Text(
                      '${booking.alamat}',
                      maxLines: 3,

                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunito(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatusColor {
  static Color getColor(String status) {
    switch (status.toLowerCase()) {
      case 'booking':
        return Colors.blue;
      case 'approve':
        return Colors.green;
      case 'diproses':
        return Colors.orange;
      case 'estimasi':
        return Colors.lime;
      case 'selesai dikerjakan':
        return Colors.blue;
      case 'pkb':
        return Colors.green;
      case 'pkb tutup':
        return Colors.deepOrangeAccent;
      case 'invoice':
        return Colors.blueAccent;
      case 'lunas':
        return Colors.lightBlue;
      case 'ditolak by sistem':
        return Colors.grey;
      case 'ditolak':
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }
}

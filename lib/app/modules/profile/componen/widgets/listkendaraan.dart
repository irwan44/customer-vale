import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/data_endpoint/customkendaraan.dart';

class ListKendaraan extends StatelessWidget {
  final DataKendaraan item;

  const ListKendaraan({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
        children: [
          Row(children: [
            Text('${item.merks?.namaMerk}', style: GoogleFonts.nunito(fontWeight: FontWeight.bold),),
            Text(' - ', style: GoogleFonts.nunito(fontWeight: FontWeight.bold),),
            ...?item.tipes?.map((tipe) => Text('${tipe.namaTipe}', style: GoogleFonts.nunito(fontWeight: FontWeight.bold),)).toList(),
          ],),
          Text('No Polisi: ${item.noPolisi}'),
          Row(children: [
            Text('${item.warna}', style: GoogleFonts.nunito(fontWeight: FontWeight.bold),),
            Text(' - ', style: GoogleFonts.nunito(fontWeight: FontWeight.bold),),
            Text('${item.tahun}', style: GoogleFonts.nunito(fontWeight: FontWeight.bold),),
          ],),
        ],
      ),
    );
  }
}

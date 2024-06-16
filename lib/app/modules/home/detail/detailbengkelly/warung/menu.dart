import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuListPage extends StatelessWidget {
  final Map<String, dynamic> tenant;

  MenuListPage({required this.tenant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tenant['name'],style: GoogleFonts.nunito()),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    tenant['image'],
                    height: 200, // Adjust the height as needed
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          tenant['name'],
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Deskripsi',
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        SizedBox(height: 10),
                        ExpandableText(
                          tenant['description'],
                          expandText: 'Lihat Selengkapnya',
                          collapseText: 'show less',
                          maxLines: 5,
                          linkColor: Colors.blue,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Menu Makanan dan Minuman',
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
          itemCount: tenant['menu'].length,
          itemBuilder: (context, index) {
            return _buildMenuItem(context, tenant['menu'][index]);
          },
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, Map<String, dynamic> menuItem) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
            ListTile(
              leading: Image.asset(
                menuItem['image'],
                width: 50,
                height: 70,
                fit: BoxFit.cover,
              ),
              title: Text(
                menuItem['name'],
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                menuItem['deskripsi'],
                style: GoogleFonts.nunito(fontSize: 14),
              ),

            ),
            Text(
              'Rp ${menuItem['harga']}',
              style: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ]
      ),
    );
  }
}

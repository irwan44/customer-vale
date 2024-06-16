import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../data/dummy_data.dart';
import 'menu.dart';

class TenantListPage extends StatelessWidget {
  final String restAreaId;

  TenantListPage({required this.restAreaId});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> filteredTenants = restAreaTenants
        .where((tenant) => tenant['restAreaId'] == restAreaId)
        .toList();

    return Container(
      height: 400, // or any height you want
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: filteredTenants.length,
        itemBuilder: (context, index) {
          final tenant = filteredTenants[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuListPage(tenant: tenant),
                ),
              );
            },
            child: Container(
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
              child: ListTile(
                leading: Image.asset(
                  tenant['image'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
                title: Text(
                  tenant['name'],
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(
                  tenant['address'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.nunito(fontSize: 14),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

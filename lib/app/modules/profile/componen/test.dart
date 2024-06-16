import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

// Assuming these are the correct imports for your API and model classes
import '../../../data/data_endpoint/generalcekup.dart';
import '../../../data/endpoint.dart';

class GeneralCheckupScreen extends StatefulWidget {
  @override
  _GeneralCheckupScreenState createState() => _GeneralCheckupScreenState();
}

class _GeneralCheckupScreenState extends State<GeneralCheckupScreen> {
  late Future<GeneralCheckup> futureGeneralCheckup;

  @override
  void initState() {
    super.initState();
    futureGeneralCheckup = API.GCMekanikID(kategoriKendaraanId: '1');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GeneralCheckup>(
        future: futureGeneralCheckup,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.dataGeneralCheckUp == null) {
            return Center(child: Text('No data available'));
          }
          final data = snapshot.data!.dataGeneralCheckUp!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return Card(
                child: ExpansionTile(
                  title: Text(item.subHeading ?? 'No subheading'),
                  children: item.gcus?.map((gcu) {
                    return ListTile(
                      title: Text(gcu.gcu ?? 'No GCU'),
                    );
                  }).toList() ?? [],
                ),
              );
            },
          );
        },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GeneralCheckupScreen(),
  ));
}

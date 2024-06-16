import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../componen/shimmerbooking.dart';
import '../../../data/data_endpoint/history.dart';
import '../../../data/endpoint.dart';
import '../../../routes/app_pages.dart';
import '../../history/componen/listhistory.dart';

class Notofikasi extends StatefulWidget {
  const Notofikasi({super.key});

  @override
  State<Notofikasi> createState() => _NotofikasiState();
}

class _NotofikasiState extends State<Notofikasi> {
  late RefreshController _refreshController;
  @override
  void initState() {
    _refreshController =
        RefreshController(); // we have to use initState because this part of the app have to restart
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        title: Text('Notifikasi'),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
      ),
      body: SmartRefresher(
    controller: _refreshController,
    enablePullDown: true,
    header: const WaterDropHeader(),
    onLoading: _onLoading,
    onRefresh: _onRefresh,
    child:
      SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: API.HistoryBookingID(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const ShimmerListHistory();
                  },
                );
              } else if (snapshot.hasError) {
                if (snapshot.error.toString().contains('404')) {
                  return Center(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logo/forbidden.png',
                          width: 60,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 10,),
                        Text('Belum ada Data History Booking')
                      ]
                  ),
                  );
                } else {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
              } else if (snapshot.hasData && snapshot.data != null) {
                HistoryBooking getDataAcc = snapshot.data ?? HistoryBooking();
                var filteredData = getDataAcc.datahistory?.where((e) => e.namaStatus == "Approve").toList() ?? [];

                if (filteredData.isEmpty) {
                  return Center(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logo/forbidden.png',
                          width: 60,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 10,),
                        Text('Belum ada History Booking')
                      ]
                  ),
                  );
                }

                return Column(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 475),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                    children: filteredData.map((e) {
                      return ListHistory(
                        booking: e,
                        onTap: () {
                          Get.toNamed(Routes.DETAILHISTORY,
                            arguments: {
                              'alamat': e.alamat ?? '',
                              'nama_cabang': e.namaCabang ?? '',
                              'nama_jenissvc': e.namaJenissvc ?? '',
                              'nama_status': e.namaStatus ?? '',
                              'jasa': e.jasa?.map((item) => item.toJson()).toList() ?? [],
                              'part': e.part?.map((item) => item.toJson()).toList() ?? [],
                            },
                          );
                        },
                      );
                    }).toList(),
                  ),
                );
              } else {
                return const Center(child: Text('Tidak ada data'));
              }
            },
          ),
        ),
      ),
      ),
    );
  }
  _onLoading() {
    _refreshController
        .loadComplete(); // after data returned,set the //footer state to idle
  }

  _onRefresh() {
    HapticFeedback.lightImpact();
    setState(() {

      const Notofikasi();
      _refreshController
          .refreshCompleted();
    });
  }
}

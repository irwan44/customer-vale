import 'package:customer_bengkelly/app/data/endpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:search_page/search_page.dart';
import '../../../componen/color.dart';
import '../../../componen/shimmerbooking.dart';
import '../../../data/data_endpoint/history.dart';
import '../../../routes/app_pages.dart';
import '../componen/listhistory.dart';
import '../controllers/history_controller.dart';

class HistoryView extends StatefulWidget {
  HistoryView({Key? key}) : super(key: key);

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  late List<RefreshController> _refreshControllers;
  late Future<HistoryBooking> _historyBookingFuture;

  @override
  void initState() {
    super.initState();
    _refreshControllers = List.generate(11, (index) => RefreshController());
    _historyBookingFuture = API.HistoryBookingID();
  }

  Future<void> handleBookingTap(DataHis booking) async {
    Get.toNamed(
      Routes.DETAILHISTORY,
      arguments: {
        'alamat': booking.alamat ?? '',
        'nama_cabang': booking.namaCabang ?? '',
        'nama_jenissvc': booking.namaJenissvc ?? '',
        'nama_status': booking.namaStatus ?? '',
        'jasa': booking.jasa?.map((item) => item.toJson()).toList() ?? [],
        'part': booking.part?.map((item) => item.toJson()).toList() ?? [],
      },
    );
  }

  void _onRefresh(int index) async {
    try {
      final newHistoryBooking = await API.HistoryBookingID();
      setState(() {
        _historyBookingFuture = Future.value(newHistoryBooking);
      });
      _refreshControllers[index].refreshCompleted();
    } catch (e) {
      _refreshControllers[index].refreshFailed();
      print('Error during refresh: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'History',
          style: GoogleFonts.nunito(
            color: MyColors.appPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.CHAT);
                },
                child: SvgPicture.asset(
                  'assets/icons/massage.svg',
                  width: 26,
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.NOTIFIKASI);
                },
                child: SvgPicture.asset(
                  'assets/icons/notif.svg',
                  width: 26,
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
      body: DefaultTabController(
        length: 11,
        child: Column(
          children: [
            FutureBuilder(
              future: _historyBookingFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center();
                } else if (snapshot.hasData && snapshot.data != null) {
                  final data = snapshot.data!.datahistory;

                  if (data != null && data.isNotEmpty) {
                    return InkWell(
                      onTap: () => showSearch(
                        context: context,
                        delegate: SearchPage<DataHis>(
                          items: data,
                          searchLabel: 'Cari Booking',
                          searchStyle: GoogleFonts.nunito(color: Colors.black),
                          showItemsOnEmpty: true,
                          failure: Center(
                            child: Text(
                              'Booking Tidak Ditemukan :(',
                              style: GoogleFonts.nunito(),
                            ),
                          ),
                          filter: (booking) => [
                            booking.noPolisi,
                          ],
                          builder: (items) => ListHistory(
                            booking: items,
                            onTap: () {
                              handleBookingTap(items);
                            },
                          ),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade100,
                          border: Border.all(color: MyColors.select),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            Icon(Icons.search_rounded, color: MyColors.appPrimaryColor),
                            const SizedBox(width: 10),
                            Text('Cari Transaksi', style: GoogleFonts.nunito(color: Colors.grey)),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Pencarian',
                        style: GoogleFonts.nunito(fontSize: 16),
                      ),
                    );
                  }
                } else {
                  return Container(
                    width: double.infinity,
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade100,
                      border: Border.all(color: MyColors.select),
                    ),
                    child: Row(
                        children: [
                        const SizedBox(width: 10),
                    Icon(Icons.search_rounded, color: MyColors.appPrimaryColor),
                    const SizedBox(width: 10),
                    Text('Cari Transaksi', style: GoogleFonts.nunito(color: Colors.grey)),
                      ]
                    ),
                  );
                 }
              },
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              color: Colors.white,
              padding: EdgeInsets.only(left: 10, bottom: 5, right: 10),
              child: TabBar(
                isScrollable: true,
                dividerColor: Colors.transparent,
                unselectedLabelColor: Colors.grey,
                labelColor: MyColors.appPrimaryColor,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: MyColors.select,
                ),
                tabs: [
                  _buildTab('Semua'),
                  _buildTab('Booking'),
                  _buildTab('Approve'),
                  _buildTab('Diproses'),
                  _buildTab('Estimasi'),
                  _buildTab('PKB'),
                  _buildTab('PKB TUTUP'),
                  _buildTab('Selesai Dikerjakan'),
                  _buildTab('Invoice'),
                  _buildTab('Lunas'),
                  _buildTab('Ditolak'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildTabContent('Semua', 0),
                  _buildTabContent('Booking', 1),
                  _buildTabContent('Approve', 2),
                  _buildTabContent('Diproses', 3),
                  _buildTabContent('Estimasi', 4),
                  _buildTabContent('PKB', 5),
                  _buildTabContent('PKB TUTUP', 6),
                  _buildTabContent('Selesai Dikerjakan', 7),
                  _buildTabContent('Invoice', 8),
                  _buildTabContent('Lunas', 9),
                  _buildTabContent('Ditolak', 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title) {
    return Tab(
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: MyColors.select, width: 1),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(title),
        ),
      ),
    );
  }

  Widget _buildTabContent(String status, int index) {
    return FutureBuilder<HistoryBooking>(
      future: _historyBookingFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return const ShimmerListHistory();
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo/forbidden.png',
                  width: 60,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 10),
                Text('Belum ada Data History Booking')
              ],
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.datahistory!.isEmpty) {
          return Center(child: Text('Belum ada Data History Booking'));
        }

        var bookings = snapshot.data!.datahistory;
        var filteredBookings = bookings?.where((booking) {
          if (status == 'Semua') return true;
          return booking.namaStatus == status;
        }).toList();

        if (filteredBookings == null || filteredBookings.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo/forbidden.png',
                  width: 60,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 10),
                Text('Belum ada Data History Booking')
              ],
            ),
          );
        }

        return SmartRefresher(
          controller: _refreshControllers[index],
          enablePullDown: true,
          header: const WaterDropHeader(),
          onRefresh: () => _onRefresh(index),
          child: SingleChildScrollView(
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 475),
                childAnimationBuilder: (widget) => SlideAnimation(
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: filteredBookings.map((booking) {
                  return ListHistory(
                    booking: booking,
                    onTap: () {
                      handleBookingTap(booking);
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

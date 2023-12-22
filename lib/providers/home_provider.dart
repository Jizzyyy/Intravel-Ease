import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:intravel_ease/configs/secure_data.dart';
import 'package:intravel_ease/controllers/produk_controller.dart';
import 'package:intravel_ease/models/produks/produk_distance_model.dart';
import 'package:intravel_ease/models/user_model.dart';
import 'package:intravel_ease/models/wisatas/wisata_model_distance.dart';
import 'package:intravel_ease/screens/detail_usaha_screen.dart';
import 'package:intravel_ease/screens/search_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../controllers/wisata_controller.dart';
import '../public_providers/public_distance_provider.dart';
import '../public_providers/public_one_provider.dart';
import '../screens/detail_place_screen.dart';
import '../screens/result_search_distance_screen.dart';
import '../screens/result_usaha_distance_screen.dart';

class HomeProvider extends ChangeNotifier {
  String? user_nama;
  late GoogleMapController googleMapController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool shimmerWisata = true;
  bool shimmerKuliner = true;
  double? latitude;
  double? longitude;
  bool? checkLocation = false;

  String toMoney(int amount) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  void toSearch(BuildContext context) {
    if (scaffoldKey.currentContext != null)
      Navigator.of(context).push(PageTransition(
          child: const SearchScreen(),
          reverseDuration: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 500),
          alignment: Alignment.topCenter,
          type: PageTransitionType.scale));
  }

  toNearestUsaha(BuildContext context) {
    final publicDistance =
        Provider.of<PublicDistanceProvider>(context, listen: false).setValues(
            latitude: this.latitude.toString(),
            longitude: this.longitude.toString());
    Navigator.of(context).push(PageTransition(
        child: const ResultUsahaDistanceScreen(),
        reverseDuration: const Duration(milliseconds: 200),
        duration: const Duration(milliseconds: 500),
        alignment: Alignment.bottomCenter,
        type: PageTransitionType.size));
  }

  void getUser() async {
    UserModel model = await SecureData.getUserData();
    user_nama = model.user_nama;
    notifyListeners();
  }

  Set<Marker> markers = {};

  CameraPosition kcameraposition = CameraPosition(
    target: LatLng(-8.28607634037758, 111.72574138995579),
    zoom: 14.4746,
  );
  //
  void toDetailWisata(BuildContext context, String idWisata) {
    Provider.of<PublicOneProvider>(context, listen: false)
        .setValues(one: idWisata);
    Navigator.of(context).push(PageTransition(
        child: const DetailPlaceScreen(),
        reverseDuration: const Duration(milliseconds: 200),
        duration: const Duration(milliseconds: 500),
        alignment: Alignment.topCenter,
        type: PageTransitionType.size));
  }

  void toDetailProduk(BuildContext context, String idProduk) {
    Provider.of<PublicOneProvider>(context, listen: false)
        .setValues(one: idProduk);
    Navigator.of(context).push(PageTransition(
        child: const DetailUsahaScreen(),
        reverseDuration: const Duration(milliseconds: 200),
        duration: const Duration(milliseconds: 500),
        alignment: Alignment.topCenter,
        type: PageTransitionType.size));
  }

  Future<List<WisataModelDistance?>> getWisata(BuildContext context) async {
    // -7.897289227450776, 112.55304314409294
    if (latitude != null && longitude != null) {
      if (scaffoldKey.currentContext != null) {
        final checkData =
            await WisataController.getWisataDistance(latitude!, longitude!);
        // final checkData = await WisataController.getWisataDistance(
        //     context, latitude!, longitude!);
        if (checkData?.status! == 400) {
          return [];
        }
        return checkData?.data ?? [];
      }
    }
    return [];
  }

  Future<List<ProdukDistanceModel>> getProduk(BuildContext context) async {
    if (latitude != null && longitude != null) {
      if (scaffoldKey.currentContext != null) {
        final checkData = await ProdukController.getProdukDistance(
            latitude.toString(), longitude.toString());
        if (checkData?.status! == 400) {
          return [];
        }
        return checkData?.data ?? [];
      }
    }
    return [];
  }

  toNearestSpot(BuildContext context) {
    final publicDistance =
        Provider.of<PublicDistanceProvider>(context, listen: false).setValues(
            latitude: this.latitude.toString(),
            longitude: this.longitude.toString());
    Navigator.of(context).push(PageTransition(
        child: const ResultSearchDistanceScreen(),
        reverseDuration: const Duration(milliseconds: 200),
        duration: const Duration(milliseconds: 500),
        alignment: Alignment.bottomCenter,
        type: PageTransitionType.size));
  }

  void getLocation(BuildContext context) async {
    try {
      bool isLocationGranted = await _checkLocationPermission();

      if (isLocationGranted) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 12)));
        markers.clear();
        markers.add(Marker(
            markerId: const MarkerId('currentLocation'),
            position: LatLng(position.latitude, position.longitude)));
        latitude = position.latitude;
        longitude = position.longitude;
        checkLocation = true;
        notifyListeners();
      } else {
        // Jika izin lokasi belum diberikan, minta izin lokasi dari pengguna
        if (scaffoldKey.currentContext != null)
          await _requestLocationPermission(context);
      }
    } catch (e) {}
    // Periksa apakah izin lokasi sudah diberikan
  }

  Future<bool> _checkLocationPermission() async {
    var status = await Permission.location.status;
    return status == PermissionStatus.granted;
  }

  Future<void> _requestLocationPermission(BuildContext context) async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      if (scaffoldKey.currentContext != null) getLocation(context);
    } else {
      print('Izin lokasi tidak diberikan.');
    }
  }
}

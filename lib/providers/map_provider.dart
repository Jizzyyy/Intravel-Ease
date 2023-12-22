import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intravel_ease/public_providers/public_add_bussiness_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MapProvider extends ChangeNotifier {
  GoogleMapController? mapController;
  Marker? marker;
  String locationData = '';
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? alamat = '', kota = '', provinsi = '', latitude = '', longitude = '';

  getProvider(BuildContext context) {
    final publicBussiness =
        Provider.of<PublicAddBussinessProvider>(context, listen: false);
    if (publicBussiness.latitude != null &&
        publicBussiness.latitude.toString().isNotEmpty) {
      alamat = publicBussiness.alamat;
      latitude = publicBussiness.latitude;
      longitude = publicBussiness.longitude;
      kota = publicBussiness.kota;
      provinsi = publicBussiness.provinsi;
      print('latitude ku : $latitude');
      notifyListeners();
    }
  }

  void placeMart(double latitude, double longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );
    String jalan = placemarks.first.thoroughfare.toString() != ''
        ? '${placemarks.first.thoroughfare}, '
        : '';
    this.latitude = latitude.toString();
    print('lagi latitude $latitude');
    this.longitude = longitude.toString();
    String desa = placemarks.first.subLocality ?? '';
    String kecamatan = placemarks.first.locality ?? '';
    kota = placemarks.first.subAdministrativeArea ?? '';
    provinsi = placemarks.first.administrativeArea ?? '';
    alamat = '${jalan}${desa}, ${kecamatan}, ${kota}, ${provinsi}';

    String locationData = 'Latitude: ${latitude.toStringAsFixed(6)}\n'
        'Longitude: ${longitude.toStringAsFixed(6)}\n'
        'Nama Alamat: ${alamat}\n';
    this.locationData = locationData;
  }

  buttonSelect(BuildContext context) {
    print('ini latitude 2: $latitude');
    Provider.of<PublicAddBussinessProvider>(context, listen: false).setValues(
        alamat: alamat,
        kota: kota,
        provinsi: provinsi,
        latitude: latitude,
        longitude: longitude);
    Navigator.pop(context);
    Navigator.of(context).pop();
  }

  void getCurrentLocation(BuildContext context) async {
    // Periksa apakah izin lokasi sudah diberikan
    bool isLocationGranted = await _checkLocationPermission();

    if (isLocationGranted) {
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      // if (isLocationServiceEnabled) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      placeMart(position.latitude, position.longitude);
      addMarker(LatLng(position.latitude, position.longitude));
      mapController!.animateCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
      );
      notifyListeners();
      // });
      // } else {
      //   if (scaffoldKey.currentContext != null)
      //     MessagesSnacbar.warning(context, 'pesan');
      //   // Jika layanan lokasi dinonaktifkan, tampilkan pesan untuk mengaktifkannya
      //   // print(
      //   //     'Layanan lokasi dinonaktifkan. Mohon aktifkan layanan lokasi pada pengaturan perangkat.');
      // }
    } else {
      if (scaffoldKey.currentContext != null)
        await _requestLocationPermission(context);
    }
  }

  Future<bool> _checkLocationPermission() async {
    var status = await Permission.location.status;
    return status == PermissionStatus.granted;
  }

  // Fungsi untuk meminta izin lokasi dari pengguna
  Future<void> _requestLocationPermission(BuildContext context) async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      if (scaffoldKey.currentContext != null) {
        getCurrentLocation(context);
      }
    } else {
      // Jika pengguna menolak izin lokasi, beri tahu pengguna atau tampilkan pesan lainnya
      print('Izin lokasi tidak diberikan.');
    }
  }

  void addMarker(LatLng latLng) {
    // Hapus marker sebelumnya jika ada
    if (marker != null) {
      // setState(() {
      markers.remove(marker);
      notifyListeners();
      // });
    }

    // Tambahkan marker baru
    // setState(() {
    marker = Marker(
      markerId: MarkerId("marker"),
      position: latLng,
    );
    markers.add(marker!);
    placeMart(latLng.latitude, latLng.longitude);

    notifyListeners();
    // });
  }

  Set<Marker> markers = {};
}

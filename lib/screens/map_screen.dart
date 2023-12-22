import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intravel_ease/providers/map_provider.dart';
import 'package:provider/provider.dart';

import '../configs/font_family.dart';
import '../widgets/text_helper.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapProvider initProvider = MapProvider();

  @override
  void initState() {
    super.initState();
    initProvider.getProvider(context);
    initProvider.addMarker(LatLng(
        initProvider.latitude.toString().isNotEmpty
            ? double.parse(initProvider.latitude.toString())
            : -7.514134243660451,
        initProvider.longitude.toString().trim().isNotEmpty
            ? double.parse(initProvider.longitude.toString())
            : 112.13797344944138));
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      initProvider.mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: initProvider,
      child: Consumer<MapProvider>(builder: (context, provider, child) {
        return Scaffold(
          key: provider.scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: TextHelper(
              text: 'Pilih Lokasi Usaha',
              fontSize: 20.sp,
              fontFamily: FontFamily.bold,
              fontColor: Colors.black,
            ),
          ),
          body: Stack(
            children: [
              GoogleMap(
                onMapCreated: onMapCreated,
                markers: provider.markers,
                onTap: (latLng) {
                  provider.addMarker(latLng);
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      provider.latitude.toString().trim().isNotEmpty
                          ? double.parse(provider.latitude.toString())
                          : -7.514134243660451,
                      provider.longitude.toString().trim().isNotEmpty
                          ? double.parse(provider.longitude.toString())
                          : 112.13797344944138), // Ganti koordinat tengah peta sesuai keinginan
                  zoom: 10,
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: FloatingActionButton(
                  onPressed: () => provider.getCurrentLocation(context),
                  child: Icon(Icons.my_location),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Info Lokasi'),
                    content: Text(provider.locationData),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          provider.buttonSelect(context);
                        },
                        child: TextHelper(
                            text: 'Pilih Lokasi Ini', fontSize: 14.sp),
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.add),
          ),
        );
      }),
    );
  }
}

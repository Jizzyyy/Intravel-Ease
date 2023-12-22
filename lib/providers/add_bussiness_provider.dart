import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intravel_ease/public_providers/public_add_bussiness_provider.dart';
import 'package:intravel_ease/screens/map_screen.dart';
import 'package:intravel_ease/screens/waiting_acc_screen.dart';
import 'package:intravel_ease/widgets/messages_snackbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../controllers/usaha_controller.dart';

class AddBussinessProvider extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  bool checkLocation = false;
  String? alamat;
  String? latitude;
  String? longitude;
  String? kota;
  String? provinsi;
  TextEditingController namaController = TextEditingController();
  TextEditingController produkController = TextEditingController();
  TextEditingController kontakController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  String? selectedValue;
  File? pickedImage;

  init(BuildContext context) {
    final publicBussiness =
        Provider.of<PublicAddBussinessProvider>(context, listen: false);
    if (publicBussiness.latitude == null) {
      checkLocation = false;
    } else {
      checkLocation = true;
      alamat = publicBussiness.alamat;
      latitude = publicBussiness.latitude;
      longitude = publicBussiness.longitude;
      kota = publicBussiness.kota;
      provinsi = publicBussiness.provinsi;
    }
    notifyListeners();
  }

  void buttonConfirm(BuildContext context) async {
    try {
      if (formKey.currentState!.validate()) {
        if (pickedImage == null) {
          MessagesSnacbar.warning(context, 'Pilih gambar toko usaha');
        } else if (latitude == null) {
          MessagesSnacbar.warning(
              context, 'Pilih terlebih dahulu lokasi usaha');
        } else {
          EasyLoading.show();
          final value = await UsahaController.addBussiness(
              selectedValue.toString(),
              namaController.text,
              produkController.text,
              kontakController.text,
              deskripsiController.text,
              latitude!,
              longitude!,
              alamat!,
              kota!,
              provinsi!,
              pickedImage!);
          EasyLoading.dismiss();
          if (scaffoldKey.currentContext != null) {
            if (value?.status == 201) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const WaitingAccScreen(),
              ));
            } else {
              MessagesSnacbar.error(context, 'Terjadi kesalahan');
            }
          }
        }
      }
    } catch (e) {
      print('selesai error : $e');
      if (scaffoldKey.currentContext != null)
        MessagesSnacbar.error(context, 'Pilih terlebih dahulu lokasi');
    }
  }

  String? validatorConfirm(String? fieldContent, String textfield) {
    if (fieldContent!.trim().isEmpty) {
      return 'Masukkan $textfield anda';
    }
    return null;
  }

  void toMap(BuildContext context) async {
    if (scaffoldKey.currentContext != null) {
      await Navigator.of(context).push(PageTransition(
          child: MapScreen(),
          reverseDuration: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 500),
          alignment: Alignment.topCenter,
          type: PageTransitionType.scale));
      init(context);
      notifyListeners();
    }
  }

  Future<void> pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final _pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (_pickedImage != null) {
      pickedImage = File(_pickedImage.path);
      notifyListeners();
    }
  }
}

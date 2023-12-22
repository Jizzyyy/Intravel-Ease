import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:intravel_ease/controllers/produk_controller.dart';
import 'package:intravel_ease/models/produks/produk_model.dart';
import 'package:intravel_ease/models/usaha_model.dart';
import 'package:intravel_ease/public_providers/public_bussiness_provider.dart';
import 'package:intravel_ease/public_providers/public_product_provider.dart';
import 'package:intravel_ease/screens/edit_product_screen.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../controllers/usaha_controller.dart';
import '../public_providers/public_add_bussiness_provider.dart';
import '../screens/add_product_screen.dart';
import '../screens/map_screen.dart';
import '../widgets/messages_snackbar.dart';

class ManageBussinessProvider extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  UsahaModel? usahaModel;
  String? selectedValue;
  String? alamat;
  String? latitude;
  String? longitude;
  String? kota;
  String? provinsi;
  TextEditingController namaController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController produkController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  File? pickedImage;

  void toMap(BuildContext context) async {
    if (scaffoldKey.currentContext != null) {
      await Navigator.of(context).push(PageTransition(
          child: MapScreen(),
          reverseDuration: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 500),
          alignment: Alignment.topCenter,
          type: PageTransitionType.scale));
      getProvider(context);
      notifyListeners();
    }
  }

  void deleteProduct(BuildContext context, String idUsaha) async {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Hapus Produk?",
      desc:
          "Apakah anda yakin untuk menghapus produk ini, klik ya untuk hapus.",
      buttons: [
        DialogButton(
          child: TextHelper(
            text: 'Ya, Hapus',
            fontSize: 17.sp,
            fontColor: AppColors.white,
          ),
          onPressed: () async {
            Navigator.pop(context);
            EasyLoading.show();
            final value = await ProdukController.destroyProduct(idUsaha);
            EasyLoading.dismiss();
            if (scaffoldKey.currentContext != null) {
              if (value!.status == 200) {
                if (scaffoldKey.currentContext != null) {
                  MessagesSnacbar.success(context, 'Produk telah dihapus');
                }
              } else {
                if (scaffoldKey.currentContext != null)
                  MessagesSnacbar.error(context, '${value!.message}');
              }
              notifyListeners();
            }
          },
          color: AppColors.black,
        ),
        DialogButton(
          child: TextHelper(text: 'Batal', fontSize: 17.sp),
          onPressed: () => Navigator.pop(context),
          color: AppColors.inputgrey,
        )
      ],
    ).show();
  }

  void buttonConfirm(BuildContext context) async {
    try {
      if (formKey.currentState!.validate()) {
        if (latitude == null) {
          MessagesSnacbar.warning(
              context, 'Pilih terlebih dahulu lokasi usaha');
        } else {
          Alert(
            context: context,
            type: AlertType.warning,
            title: "Ubah Usaha?",
            desc: "Pastikan anda yakin untuk mengubah data usaha ini.",
            buttons: [
              DialogButton(
                child: TextHelper(
                  text: 'Ya, Ubah',
                  fontSize: 17.sp,
                  fontColor: AppColors.white,
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  EasyLoading.show();
                  final value = await UsahaController.updateUsaha(
                    selectedValue.toString(),
                    namaController.text,
                    produkController.text,
                    contactController.text,
                    deskripsiController.text,
                    latitude!,
                    longitude!,
                    alamat!,
                    kota!,
                    provinsi!,
                    pickedImage,
                    usahaModel!.usaha_id.toString(),
                  );
                  EasyLoading.dismiss();
                  if (scaffoldKey.currentContext != null) {
                    if (value!.status == 200) {
                      if (scaffoldKey.currentContext != null) {
                        MessagesSnacbar.success(
                            context, 'Data berhasil diubah');
                        usahaModel = value.data;
                      }
                    } else {
                      if (scaffoldKey.currentContext != null)
                        MessagesSnacbar.error(context, '${value!.message}');
                    }
                  }
                },
                color: AppColors.black,
              ),
              DialogButton(
                child: TextHelper(text: 'Batal', fontSize: 17.sp),
                onPressed: () => Navigator.pop(context),
                color: AppColors.inputgrey,
              )
            ],
          ).show();
        }
      }
    } catch (e) {
      print('selesai error : $e');
      if (scaffoldKey.currentContext != null)
        MessagesSnacbar.error(context, 'Pilih terlebih dahulu lokasi');
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

  toAddProduct(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const AddProductScreen()),
    );
    notifyListeners();
  }

  toEditProduct(BuildContext context, String idProduk, String image,
      String nama, String harga) async {
    Provider.of<PublicProductProvider>(context, listen: false)
        .setValues(idProduct: idProduk, image: image, nama: nama, harga: harga);
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const EditProductScreen()),
    );
    notifyListeners();
  }

  getProvider(BuildContext context) {
    final publicBussiness =
        Provider.of<PublicAddBussinessProvider>(context, listen: false);
    alamat = publicBussiness.alamat;
    latitude = publicBussiness.latitude;
    longitude = publicBussiness.longitude;
    kota = publicBussiness.kota;
    provinsi = publicBussiness.provinsi;
    notifyListeners();
  }

  saveProvider(BuildContext context) {
    notifyListeners();
  }

  Future<List<ProdukModel?>> getProduk(BuildContext context) async {
    final produk =
        await ProdukController.getProduk(usahaModel!.usaha_id.toString());
    if (produk!.status == 200) {
      return produk.data!;
    }
    return [];
  }

  String toMoney(int amount) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  void init(BuildContext context) {
    final dataProvider =
        Provider.of<PublicBussinessProvider>(context, listen: false);
    usahaModel = dataProvider.usahaModel;
    namaController.text = usahaModel!.usaha_nama!;
    deskripsiController.text = usahaModel!.usaha_deskripsi!;
    contactController.text = usahaModel!.usaha_kontak!;
    produkController.text = usahaModel!.usaha_produk!;
    selectedValue = usahaModel!.usaha_idkategori.toString();
    alamat = usahaModel!.usaha_alamat;
    latitude = usahaModel!.usaha_latitude.toString();
    print('latitude ini : $latitude');
    longitude = usahaModel!.usaha_longitude.toString();
    kota = usahaModel!.usaha_kota;
    provinsi = usahaModel!.usaha_provinsi;
    Provider.of<PublicAddBussinessProvider>(context, listen: false).setValues(
        alamat: usahaModel!.usaha_alamat,
        kota: usahaModel!.usaha_kota,
        provinsi: usahaModel!.usaha_kota,
        latitude: usahaModel!.usaha_latitude.toString(),
        longitude: usahaModel!.usaha_longitude.toString());
    notifyListeners();
    saveProvider(context);
  }

  String? validatorConfirm(String? fieldContent, String textfield) {
    if (fieldContent!.trim().isEmpty) {
      return 'Masukkan $textfield anda';
    }
    return null;
  }
}

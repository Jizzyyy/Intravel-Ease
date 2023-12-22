import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intravel_ease/controllers/produk_controller.dart';
import 'package:intravel_ease/public_providers/public_product_provider.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../configs/app_color.dart';
import '../widgets/messages_snackbar.dart';
import '../widgets/text_helper.dart';

class EditProductProvider extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  File? pickedImage;
  String? image;
  String? idProduk;
  TextEditingController namaController = TextEditingController();
  TextEditingController hargaController = TextEditingController();

  init(BuildContext context) {
    final provider = Provider.of<PublicProductProvider>(context, listen: false);
    namaController.text = provider.nama!;
    hargaController.text = provider.harga!;
    image = provider.image;
    idProduk = provider.idProduct;
  }

  void updateProduct(BuildContext context) async {
    try {
      if (formKey.currentState!.validate()) {
        Alert(
          context: context,
          type: AlertType.warning,
          title: "Ubah Produk?",
          desc: "Pastikan anda yakin untuk mengubah produk ini.",
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
                final value = await ProdukController.updateProduct(
                    idProduk.toString(),
                    namaController.text,
                    hargaController.text,
                    pickedImage);
                EasyLoading.dismiss();
                if (scaffoldKey.currentContext != null) {
                  if (value!.status == 200) {
                    if (scaffoldKey.currentContext != null) {
                      Navigator.pop(context);
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

  String? validatorConfirm(String? value, String textfield) {
    if (value!.trim().isEmpty) {
      return 'Masukkan $textfield anda';
    }
    return null;
  }
}

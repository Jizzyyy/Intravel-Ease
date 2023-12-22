import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intravel_ease/configs/secure_data.dart';
import 'package:intravel_ease/controllers/user_controller.dart';
import 'package:intravel_ease/models/user_model.dart';

import '../configs/app_color.dart';
import '../widgets/messages_snackbar.dart';
import '../widgets/text_helper.dart';

class EditAccountProvider extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController teleponController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? foto;
  String? email;

  Future<UserModel> getUser() async {
    UserModel data = await SecureData.getUserData();
    namaController.text.toString().trim().isEmpty
        ? namaController.text = data.user_nama.toString()
        : null;
    teleponController.text.toString().trim().isEmpty
        ? teleponController.text = data.user_telepon ?? ''
        : null;
    alamatController.text.toString().trim().isEmpty
        ? alamatController.text = data.user_alamat ?? ''
        : null;
    selectedValue.toString().trim().isEmpty
        ? selectedValue = data.user_gender ?? ''
        : null;
    foto == data.user_foto;
    print('ini foto ${data.user_foto}');
    email = data.user_email;
    return data;
  }

  ImagePicker imagePicker = ImagePicker();
  File? pickedImage;

  String? selectedValue;
  List<String> genderOptions = [
    'Pilih Jenis Kelamin',
    'Laki-Laki',
    'Perempuan'
  ];

  Future<void> pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final _pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (_pickedImage != null) {
      pickedImage = File(_pickedImage.path);
      notifyListeners();
    }
  }

  void buttonSave(BuildContext context) async {
    EasyLoading.show();
    final value = await UserController.updateUser(
        email.toString(),
        namaController.text,
        teleponController.text,
        selectedValue.toString(),
        alamatController.text,
        passwordController.text,
        pickedImage);
    EasyLoading.dismiss();
    if (scaffoldKey.currentContext != null) {
      if (value!.status == 200) {
        if (scaffoldKey.currentContext != null) {
          MessagesSnacbar.success(context, 'Berhasil Diubah');
          Navigator.pop(context);
          const storage = FlutterSecureStorage();
          String jsonString = json.encode(value.data?.toJson());
          await storage.write(key: 'user_data', value: jsonString);
        }
      } else {
        if (scaffoldKey.currentContext != null)
          MessagesSnacbar.error(context, '${value.title}');
        Navigator.pop(context);
      }
    }
  }

  void buttonKu(BuildContext context) async {
    if (formKey.currentState!.validate()) showPasswordDialog(context);
  }

  Future<void> showPasswordDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Masukkan Password'),
            content: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(hintText: "Konfirmasi Password"),
            ),
            actions: [
              Expanded(
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                  onPressed: () {
                    passwordController.text = '';
                    Navigator.pop(context);
                  },
                  child: TextHelper(text: 'Batal', fontSize: 18.sp),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _focusNode.unfocus();
                    buttonSave(context);
                    passwordController.text = '';
                  },
                  child: TextHelper(text: 'Simpan', fontSize: 18.sp),
                ),
              )
            ],
          );
        });
  }
}

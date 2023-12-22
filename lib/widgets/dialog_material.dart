import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class DialogMaterial {
  static void yesNo(BuildContext context, VoidCallback save) {
    Dialogs.materialDialog(
        msg: 'Yakin Ingin Menghapus Agenda Ini?',
        title: "Hapus Agenda",
        color: Colors.white,
        context: context,
        dialogWidth: 100.w,
        actions: [
          IconsOutlineButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            text: 'Jangan Hapus',
            iconData: Icons.cancel_outlined,
            textStyle: const TextStyle(color: Colors.grey),
            iconColor: Colors.grey,
          ),
          IconsButton(
            onPressed: save,
            text: "Ya, Hapus",
            iconData: Icons.delete,
            color: Colors.red,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }
}

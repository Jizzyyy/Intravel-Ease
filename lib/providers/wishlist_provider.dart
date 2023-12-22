import 'package:flutter/material.dart';
import 'package:intravel_ease/screens/detail_usaha_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../models/model_shared_preferences/favorite_model.dart';
import '../public_providers/public_one_provider.dart';
import '../screens/detail_place_screen.dart';
import '../widgets/messages_snackbar.dart';

class WishlistProvider extends ChangeNotifier {
  void removeFavorite(BuildContext context, int index) async {
    await FavoriteModel.removeFavoriteAtIndex(index);
    MessagesSnacbar.success(context, 'Berhasil Dihapus');
    notifyListeners();
  }

  void toDetailWisata(BuildContext context, String idWisata, String kategori) {
    Provider.of<PublicOneProvider>(context, listen: false)
        .setValues(one: idWisata);
    if (kategori == '1') {
      Navigator.of(context).push(PageTransition(
          child: const DetailPlaceScreen(),
          reverseDuration: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 500),
          alignment: Alignment.topCenter,
          type: PageTransitionType.size));
    } else {
      Navigator.of(context).push(PageTransition(
          child: const DetailUsahaScreen(),
          reverseDuration: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 500),
          alignment: Alignment.topCenter,
          type: PageTransitionType.size));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:intravel_ease/models/model_shared_preferences/agenda_model.dart';
import 'package:intravel_ease/widgets/messages_snackbar.dart';

class EditListProvider extends ChangeNotifier {
  void removeItinerary(BuildContext context, int index) async {
    await AgendaModel.removeItineraryAtIndex(index);
    MessagesSnacbar.success(context, 'Berhasil Dihapus');
    Navigator.pop(context);
    notifyListeners();
  }
    
}

import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/models/card.dart' as bizcard;
class BizcardPreviewViewModel extends BaseViewModel {
  
  bizcard.Card? card;
  bool isOwnCard = false;

  @override
  void dispose() {
    
  }
}
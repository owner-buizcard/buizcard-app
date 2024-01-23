import 'package:bizcard_app/base/base_viewmodel.dart';
import 'package:bizcard_app/models/card.dart' as bizcard;
import 'package:bizcard_app/utils/global.dart';

class BizcardPreviewViewModel extends BaseViewModel {
  
  late bizcard.Card card;

  BizcardPreviewViewModel(String cardId){
    card = Global.cards.value.firstWhere((element) => element.id==cardId);
  }

  @override
  void dispose() {
    
  }
}
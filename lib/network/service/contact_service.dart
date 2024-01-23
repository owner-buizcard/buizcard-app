import 'package:bizcard_app/models/contact_info.dart';
import 'package:bizcard_app/network/api_client.dart';

class ContactService {

  Future<dynamic> saveContactDetails({required ContactInfo details})async{
    ApiClient client = ApiClient('/contact-details');
    return await client.put(details.toJson());
  }

}
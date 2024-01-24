import 'package:bizcard_app/models/contact_info.dart';
import 'package:bizcard_app/network/api_client.dart';

class ContactService {

  Future<dynamic> saveContactDetails({required ContactInfo details})async{
    ApiClient client = ApiClient('/contact-details');
    return await client.post(details.toJson());
  }

  Future<dynamic> updateContactDetails({required String contactId, required Map data})async{
    ApiClient client = ApiClient('/contact?contactId=$contactId', loader: false);
    return await client.put(data);
  }

  Future<dynamic> deleteContact({required String contactId})async{
    ApiClient client = ApiClient('/contact?contactId=$contactId');
    return await client.delete();
  }

}
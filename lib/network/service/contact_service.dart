import 'package:bizcard_app/models/contact_info.dart';
import 'package:bizcard_app/network/api_client.dart';

class ContactService {
  Future<dynamic> saveContact({required String cardId})async{
    ApiClient client = ApiClient('/contact', loader: false);
    return await client.post({'cardId': cardId, 'type': 'Bizcard'});
  }

  Future<dynamic> saveContactDetails({required ContactInfo details})async{
    ApiClient client = ApiClient('/contact-details');
    return await client.post(details.toJson());
  }

  Future<dynamic> updateContactDetails({required String contactId, required Map data, bool loader = false})async{
    ApiClient client = ApiClient('/contact?contactId=$contactId', loader: loader);
    return await client.put(data);
  }

  Future<dynamic> deleteContact({required String contactId})async{
    ApiClient client = ApiClient('/contact?contactId=$contactId', loader: false);
    return await client.delete();
  }

  Future<dynamic> exportToZohoCRM({required List ids})async{
    ApiClient client = ApiClient('/zoho/export');
    return await client.post({'contactIds': ids});
  }

  Future<dynamic> exportToHubspotCRM({required List ids})async{
    ApiClient client = ApiClient('/hubspot/export');
    return await client.post({'contactIds': ids});
  }

  Future<dynamic> exportToSpreadsheet({required List ids})async{
    ApiClient client = ApiClient('/spreadsheet/export');
    return await client.post({'contactIds': ids});
  }

  Future<dynamic> sendMail(data)async{
    ApiClient client = ApiClient('/contact/mail');
    return await client.post(data);
  }


}
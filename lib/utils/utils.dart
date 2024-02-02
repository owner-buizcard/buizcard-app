

import 'dart:io';

import 'package:bizcard_app/models/contact.dart';
import 'package:intl/intl.dart';
import 'package:open_file_plus/open_file_plus.dart';


String formatDate(dateString){
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('dd MMM').format(dateTime);
}


Future<void> saveVCard({required Contact contact}) async {
  try {
    String name = contact.card?.name!=null ? '${contact.card?.name?.firstName} ${contact.card?.name?.lastName}' : contact.details?.name ?? '';
    String company = contact.card?.company?.companyName ?? contact.details?.company ?? '';
    String title = contact.card?.company?.title ?? contact.details?.title ?? '';
    String address = contact.card?.address?.string() ?? contact.details?.location ?? '';
    String phoneNumber = contact.card?.phoneNumber ?? contact.details?.phone ?? '';
    String email = contact.card?.email ?? contact.details?.email ?? '';

    String vCardContent = '''
      BEGIN:VCARD
      VERSION:3.0
      N:$name
      TEL;TYPE=CELL:$phoneNumber
      EMAIL:$email
      ORG:$company
      TITLE:$title
      ADR;TYPE=HOME:$address
      END:VCARD
      ''';

    final directory = Directory('/storage/emulated/0/Download');
    final file = File('${directory.path}/$name bizcard.vcf');
    await file.writeAsString(vCardContent);
    OpenFile.open(file.path);
  } catch (_) {}
}
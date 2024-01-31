import 'package:bizcard_app/models/address.dart';
import 'package:bizcard_app/models/company.dart';
import 'package:bizcard_app/models/field_value.dart';
import 'package:bizcard_app/models/name.dart';
import 'package:bizcard_app/models/qr_info.dart';
import 'package:equatable/equatable.dart';

class Card extends Equatable {
  final String id;
  final String cardName;
  final Name? name;
  final String? bio;
  final String? phoneNumber;
  final String? email;
  final Address? address;
  final Company? company;
  final String? picture;
  final String? logo;
  final String? banner;
  final String design;
  final String theme;
  final String status;
  final List badges;
  final List<FieldValue> fields;
  final QrInfo? qr;
  final String? cardLink;
  final String? linkPreviewImage;
  final bool qrVisible;
  final bool qrWithLogo;
  final bool isPublic;
  final String createdBy;
  final DateTime created;
  final DateTime updated;
  final DateTime? deleted;
  
  const Card({
    required this.id,
    required this.cardName,
    this.name,
    this.bio,
    this.phoneNumber,
    this.email,
    this.address,
    this.company,
    this.picture,
    this.logo,
    this.banner,
    required this.design,
    required this.theme,
    required this.status,
    required this.badges,
    required this.fields,
    this.qr,
    this.cardLink,
    this.linkPreviewImage,
    required this.qrVisible,
    required this.qrWithLogo,
    required this.isPublic,
    required this.createdBy,
    required this.created,
    required this.updated,
    this.deleted,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'cardName': cardName,
      'name': name?.toJson(),
      'bio': bio,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address?.toJson(),
      'company': company?.toJson(),
      'picture': picture,
      'logo': logo,
      'banner': banner,
      'design': design,
      'theme': theme,
      'status': status,
      'badges': List<dynamic>.from(badges),
      'fields': List<dynamic>.from(fields.map((e) => e.toJson())),
      'qr': qr?.toJson(),
      'cardLink': cardLink,
      'linkPreviewImage': linkPreviewImage,
      'qrVisible': qrVisible,
      'qrWithLogo': qrWithLogo,
      'isPublic': isPublic,
      'createdBy': createdBy,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
    };
  }


  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json['_id'] as String,
      cardName: json['cardName'] as String,
      name: json['name']!=null ? Name.fromJson(json['name']) : null,
      bio: json['bio'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      address: json['address']!=null ? Address.fromJson(json['address']) : null,
      company: json['company']!=null ? Company.fromJson(json['company']) : null,
      picture: json['picture'] as String?,
      logo: json['logo'] as String?,
      banner: json['banner'] as String?,
      design: json['design'] as String,
      theme: json['theme'] as String,
      status: json['status'] as String,
      badges: List.from(json['badges'] as List),
      fields: json['fields']!=null ? (json['fields'] as List).map((e) => FieldValue.fromJson(e)).toList(): [],
      qr: json['qr']!=null ? QrInfo.fromJson(json['qr']) : null,
      cardLink: json['cardLink'] as String?,
      linkPreviewImage: json['linkPreviewImage'] as String?,
      qrVisible: json['qrVisible'] as bool,
      qrWithLogo: json['qrWithLogo'] as bool,
      isPublic: json['isPublic'] as bool,
      createdBy: json['createdBy'] as String,
      created: DateTime.parse(json['created'] as String),
      updated: DateTime.parse(json['updated'] as String),
      deleted: json['deleted'] != null
          ? DateTime.parse(json['deleted'] as String)
          : null,
    );
  }
  
  @override
  List<Object?> get props => throw UnimplementedError();
}

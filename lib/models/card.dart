import 'package:bizcard_app/models/name.dart';
import 'package:equatable/equatable.dart';

class Card extends Equatable {
  final String cardName;
  final Name? name;
  final String? bio;
  final String? phoneNumber;
  final String? email;
  final Map? address;
  final Map? company;
  final String? picture;
  final String? logo;
  final String? banner;
  final String design;
  final String theme;
  final String status;
  final List badges;
  final List fields;
  final Map? qr;
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

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      cardName: json['cardName'] as String,
      name: json['name']!=null ? Name.fromJson(json['name']) : null,
      bio: json['bio'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      address: json['address'] as Map?,
      company: json['company'] as Map?,
      picture: json['picture'] as String?,
      logo: json['logo'] as String?,
      banner: json['banner'] as String?,
      design: json['design'] as String,
      theme: json['theme'] as String,
      status: json['status'] as String,
      badges: List.from(json['badges'] as List),
      fields: List.from(json['fields'] as List),
      qr: json['qr'] as Map?,
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

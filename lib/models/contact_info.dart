import 'package:bizcard_app/extensions/string_ext.dart';
import 'package:equatable/equatable.dart';

class ContactInfo extends Equatable {

  final String? name;
  final String? email;
  final String? phone;
  final String? title;
  final String? picture;
  final String? company;
  final String? website;
  final String? location;

  const ContactInfo({
    required this.name,
    required this.email,
    required this.phone,
    required this.title,
    this.picture,
    required this.company,
    required this.website,
    required this.location,
  });

  ContactInfo copyWith({
    String? name,
    String? email,
    String? phone,
    String? title,
    String? company,
    String? website,
    String? location,
  }) {
    return ContactInfo(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      title: title ?? this.title,
      company: company ?? this.company,
      website: website ?? this.website,
      location: location ?? this.location,
    );
  }

  factory ContactInfo.fromJson(Map<String, dynamic> map) {
    return ContactInfo(
      name: '${map['name']}'.nullIfEmpty(),
      email: '${map['email']}'.nullIfEmpty(),
      phone: '${map['phone']}'.nullIfEmpty(),
      picture: '${map['picture']}'.nullIfEmpty(),
      title: '${map['title']}'.nullIfEmpty(),
      company: '${map['company']}'.nullIfEmpty(),
      website: '${map['website']}'.nullIfEmpty(),
      location: '${map['location']}'.nullIfEmpty(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name.nullIfEmpty(),
      'email': email.nullIfEmpty(),
      'phone': phone.nullIfEmpty(),
      'picture': picture.nullIfEmpty(),
      'title': title.nullIfEmpty(),
      'company': company.nullIfEmpty(),
      'website': website.nullIfEmpty(),
      'location': location.nullIfEmpty(),
    };
  }

  @override
  bool get stringify => true;
  
  @override
  List<Object?> get props => [];
}

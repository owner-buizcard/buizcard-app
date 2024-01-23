import 'package:equatable/equatable.dart';

class ContactInfo extends Equatable {

  final String? name;
  final String? email;
  final String? phone;
  final String? title;
  final String? company;
  final String? website;
  final String? location;

  const ContactInfo({
    required this.name,
    required this.email,
    required this.phone,
    required this.title,
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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'title': title,
      'company': company,
      'website': website,
      'location': location,
    };
  }

  factory ContactInfo.fromJson(Map<String, dynamic> map) {
    return ContactInfo(
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      title: map['title'],
      company: map['company'],
      website: map['website'],
      location: map['location']
    );
  }

  @override
  bool get stringify => true;
  
  @override
  List<Object?> get props => [];
}

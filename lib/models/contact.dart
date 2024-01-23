import 'package:equatable/equatable.dart';

import 'package:bizcard_app/models/card.dart';

import 'contact_info.dart';

class Contact extends Equatable {

  final String id;
  final String userId;
  final String type;
  final String status;
  final Card? card;
  final ContactInfo? details;

  const Contact({
    required this.id,
    required this.userId,
    required this.type,
    required this.status,
    this.card,
    this.details
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'type': type,
      'status': status,
      'card': card?.toJson(),
      'info': details?.toJson()
    };
  }

  factory Contact.fromJson(Map<String, dynamic> map) {
    return Contact(
      id: map['_id'] as String,
      userId: map['userId'] as String,
      type: map['type'] as String,
      status: map['status'] as String,
      card: map['card'] != null ? Card.fromJson(map['card'] as Map<String,dynamic>) : null,
      details: map['details'] != null ? ContactInfo.fromJson(map['details'] as Map<String,dynamic>) : null,
    );
  }

  @override
  List<Object> get props {
    return [];
  }
}

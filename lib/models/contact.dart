import 'package:equatable/equatable.dart';

import 'package:bizcard_app/models/card.dart';

import 'contact_info.dart';

class Contact extends Equatable {

  final String id;
  final String userId;
  final String type;
  final String status;
  final Card? card;
  final bool isFavourite;
  final ContactInfo? details;
  final List tags;
  final String notes;
  final DateTime connectedAt;
  final String? connectedBy;


  const Contact({
    required this.id,
    required this.userId,
    required this.type,
    required this.status,
    this.card,
    this.details,
    this.isFavourite = false,
    this.tags = const [],
    this.notes = '',
    required this.connectedAt,
    this.connectedBy
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'type': type,
      'status': status,
      'card': card?.toJson(),
      'info': details?.toJson(),
      'isFavourite': isFavourite,
      'notes': notes,
      'tags': tags,
      'connectedAt': connectedAt.toIso8601String(),
      'connectedBy': connectedBy,
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
      isFavourite: map['isFavourite'] ?? false,
      tags: map['tags'] ?? [],
      connectedBy: map['connectedBy'],
      notes: map['notes'] ?? '',
      connectedAt: DateTime.parse(map['connectedAt'] as String),
    );
  }

  @override
  List<Object> get props {
    return [];
  }
}

import 'package:equatable/equatable.dart';

class Field extends Equatable {
  final String id;
  final String label;
  final String icon;
  final String regex;
  final String category;
  final String type;

  const Field({
    required this.id,
    required this.label,
    required this.icon,
    required this.regex,
    required this.category,
    required this.type,
  });

  factory Field.fromJson(Map<String, dynamic> map) {
    return Field(
      id: map['_id'] as String,
      label: map['label'] as String,
      icon: map['icon'] as String,
      regex: map['regex'] as String,
      category: map['category'] as String,
      type: map['type'] as String,
    );
  }

  @override
  bool get stringify => true;
  
  @override
  List<Object?> get props => [];
}

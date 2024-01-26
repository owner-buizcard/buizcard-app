import 'package:equatable/equatable.dart';

class Integration extends Equatable {
  final String id;
  final String name;
  final String authLink;
  final String image;
  final String description;
  final String group;
  final String authType;

  const Integration({
    required this.id,
    required this.name,
    required this.authLink,
    required this.image,
    required this.description,
    required this.group,
    required this.authType,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'auth_link': authLink,
      'image': image,
      'description': description,
      'group': group,
      'auth_type': authType,
    };
  }

  factory Integration.fromJson(Map<String, dynamic> map) {
    return Integration(
      id: map['id'] as String,
      name: map['name'] as String,
      authLink: map['auth_link'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      group: map['group'] as String,
      authType: map['auth_type'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      authLink,
      image,
      description,
      group,
      authType,
    ];
  }
}

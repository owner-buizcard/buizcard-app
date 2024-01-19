import 'package:equatable/equatable.dart';

class Name extends Equatable {

  final String? firstName;
  final String? lastName;
  final String? middleName;
  final String? prefix;
  
  const Name({
    this.firstName,
    this.lastName,
    this.middleName,
    this.prefix,
  });

  factory Name.fromJson(Map<String, dynamic> map) {
    return Name(
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      middleName: map['middleName'] != null ? map['middleName'] as String : null,
      prefix: map['prefix'] != null ? map['prefix'] as String : null,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      'prefix': prefix,
    };
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}

import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String? title;
  final String? department;
  final String? companyName;
  final String? companyWebsite;
  final String? companyDescription;

  const Company({
    required this.title,
    required this.department,
    required this.companyName,
    required this.companyWebsite,
    required this.companyDescription,
  });

  factory Company.fromJson(Map<String, dynamic> map) {
    return Company(
      title: map['title'] as String?,
      department: map['department'] as String?,
      companyName: map['companyName'] as String?,
      companyWebsite: map['companyWebsite'] as String?,
      companyDescription: map['companyDescription'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'department': department,
      'companyName': companyName,
      'companyWebsite': companyWebsite,
      'companyDescription': companyDescription,
    };
  }


  @override
  List<Object> get props {
    return [];
  }
}

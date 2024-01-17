
import 'package:equatable/equatable.dart';

class FieldValue extends Equatable {

  final String id;
  final String title;
  final String link;
  final String icon;
  final bool highlight;
  final String? desc;
  const FieldValue({
    required this.id,
    required this.title,
    required this.link,
    required this.icon,
    required this.highlight,
    this.desc,
  });


  factory FieldValue.fromJson(Map<String, dynamic> map) {
    return FieldValue(
      id: map['_id'] as String,
      title: map['title'] as String,
      link: map['link'] as String,
      icon: map['icon'] as String,
      highlight: map['highlight'] as bool,
      desc: map['desc'] != null ? map['desc'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'link': link,
      'icon': icon,
      'highlight': highlight,
      'desc': desc,
    };
  }

  @override
  bool get stringify => true;
  
  @override
  List<Object?> get props => [];
}

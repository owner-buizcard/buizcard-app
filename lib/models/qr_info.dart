
import 'package:equatable/equatable.dart';

class QrInfo extends Equatable {
  final String? logo;
  final String codeStyle;
  final String eyeStyle;
  final String fgColor;
  final String eyeColor;
  
  const QrInfo({
    required this.logo,
    required this.codeStyle,
    required this.eyeStyle,
    required this.fgColor,
    required this.eyeColor,
  });

  QrInfo copyWith({
    String? logo,
    String? codeStyle,
    String? eyeStyle,
    String? fgColor,
    String? eyeColor,
  }) {
    return QrInfo(
      logo: logo,
      codeStyle: codeStyle ?? this.codeStyle,
      eyeStyle: eyeStyle ?? this.eyeStyle,
      fgColor: fgColor ?? this.fgColor,
      eyeColor: eyeColor ?? this.eyeColor,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'logo': logo,
      'codeStyle': codeStyle,
      'eyeStyle': eyeStyle,
      'fgColor': fgColor,
      'eyeColor': eyeColor,
    };
  }

  factory QrInfo.fromJson(Map<String, dynamic> map) {
    return QrInfo(
      logo: map['logo'],
      codeStyle: map['codeStyle'] as String,
      eyeStyle: map['eyeStyle'] as String,
      fgColor: map['fgColor'] as String,
      eyeColor: map['eyeColor'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [];
  }
}

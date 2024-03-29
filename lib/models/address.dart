
import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;
  final String? country;
  final String? pincode;
  
  const Address({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
  });

  

  @override
  List<Object> get props {
    return [];
  }

  factory Address.fromJson(Map<String, dynamic> map) {
    return Address(
      addressLine1: map['addressLine1'] as String?,
      addressLine2: map['addressLine2'] as String?,
      city: map['city'] as String?,
      state: map['state'] as String?,
      country: map['country'] as String?,
      pincode: map['pincode'] as String?,
    );
  }

  String string() {
    List<String> components = [
      if (addressLine1 != null) '$addressLine1, ',
      if (addressLine2 != null) '$addressLine2, ',
      if (city != null) '$city, ',
      if (state != null) '$state, ',
      if (country != null) '$country, ',
      if (pincode != null) '$pincode, ',
    ];

    return components.join();
  }


  Map<String, dynamic> toJson() {
    return {
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode,
    };
  }


  @override
  bool get stringify => true;
}

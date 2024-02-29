class Plan {

  final String id;
  final String name;
  final String description;
  final List features;
  final String offer;
  final Map price;

  const Plan({
    required this.id,
    required this.name,
    required this.description,
    required this.features,
    required this.offer,
    required this.price,
  });

  factory Plan.fromJson(Map<String, dynamic> map) {
    return Plan(
      id: map['_id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      features: List.from((map['features'] as List)),
      offer: map['offer'] as String,
      price: Map.from((map['price'] as Map)),
    );
  }
}

class Subscription {

  final String userId;
  final Map plan;
  final String startAt;
  final String endAt;

  Subscription({
    required this.userId,
    required this.plan,
    required this.startAt,
    required this.endAt,
  });

  factory Subscription.fromJson(Map<String, dynamic> map) {
    return Subscription(
      userId: map['userId'] as String,
      plan: Map.from((map['plan'] as Map)),
      startAt: map['startAt'] as String,
      endAt: map['endAt'] as String,
    );
  }
}

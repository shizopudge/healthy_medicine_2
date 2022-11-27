class Clinic {
  final String address;
  final String city;
  final String id;
  Clinic({
    required this.address,
    required this.city,
    required this.id,
  });

  Clinic copyWith({
    String? address,
    String? city,
    String? id,
  }) {
    return Clinic(
      address: address ?? this.address,
      city: city ?? this.city,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'city': city,
      'id': id,
    };
  }

  factory Clinic.fromMap(Map<String, dynamic> map) {
    return Clinic(
      address: map['address'] as String,
      city: map['city'] as String,
      id: map['id'] as String,
    );
  }

  @override
  String toString() => 'Clinic(address: $address, city: $city, id: $id)';

  @override
  bool operator ==(covariant Clinic other) {
    if (identical(this, other)) return true;

    return other.address == address && other.city == city && other.id == id;
  }

  @override
  int get hashCode => address.hashCode ^ city.hashCode ^ id.hashCode;
}

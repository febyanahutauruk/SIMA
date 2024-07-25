class Warehouse {
  final String code;
  final String name;
  final String address;
  final double? longitude; // Nullable
  final double? latitude; // Nullable
  final String locationName;
  final int id;

  Warehouse({
    required this.code,
    required this.name,
    required this.address,
    this.longitude,
    this.latitude,
    required this.locationName,
    required this.id,
  });

  // Factory constructor to create a Warehouse from JSON
  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      code: json['code'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      locationName: json['locationName'] as String,
      id: json['id'] as int,
    );
  }

  // Method to convert a Warehouse to JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'address': address,
      'longitude': longitude,
      'latitude': latitude,
      'locationName': locationName,
      'id': id,
    };
  }
}

class Room {
  final int id;
  final String name;
  final String building;
  final String imageUrl;
  final int capacity;
  final List<String> facilities;
  final String wifiSpeed;
  final bool isAvailable;
  final bool isFavorite;
  final String status;
  final String buildingId;

  const Room({
    required this.id,
    required this.name,
    required this.building,
    required this.imageUrl,
    this.capacity = 30,
    this.facilities = const [],
    this.wifiSpeed = '100 Mbps',
    this.isAvailable = true,
    this.isFavorite = false,
    this.status = 'ready',
    this.buildingId = '',
  });
}

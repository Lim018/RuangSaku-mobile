class Room {
  final int id;
  final String name;
  final String building;
  final String imageUrl;
  final int capacity;
  final String facilities;
  final String wifiSpeed;
  final bool isAvailable;

  const Room({
    required this.id,
    required this.name,
    required this.building,
    required this.imageUrl,
    this.capacity = 45,
    this.facilities = 'Smart TV',
    this.wifiSpeed = '1 Gbps',
    this.isAvailable = true,
  });
}

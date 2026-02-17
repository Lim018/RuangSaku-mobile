import 'package:flutter/material.dart';
import 'models/building.dart';
import 'models/room.dart';
import 'models/booking.dart';

class DummyData {
  // Buildings — 8 entries matching V2 design
  static const List<Building> buildings = [
    Building(
        id: 1,
        name: 'Teknik',
        icon: 'cpu',
        color: Color(0xFFDBEAFE),
        roomCount: 12),
    Building(
        id: 2,
        name: 'Ekonomi',
        icon: 'bar-chart-3',
        color: Color(0xFFDBEAFE),
        roomCount: 8),
    Building(
        id: 3,
        name: 'Hukum',
        icon: 'scale',
        color: Color(0xFFDBEAFE),
        roomCount: 6),
    Building(
        id: 4,
        name: 'Sastra',
        icon: 'pen-tool',
        color: Color(0xFFDBEAFE),
        roomCount: 5),
    Building(
        id: 5,
        name: 'Kedokteran',
        icon: 'heart-pulse',
        color: Color(0xFFDBEAFE),
        roomCount: 10),
    Building(
        id: 6,
        name: 'MIPA',
        icon: 'beaker',
        color: Color(0xFFDBEAFE),
        roomCount: 9),
    Building(
        id: 7,
        name: 'FISIP',
        icon: 'users-2',
        color: Color(0xFFDBEAFE),
        roomCount: 7),
    Building(
        id: 8,
        name: 'Bahasa',
        icon: 'palette',
        color: Color(0xFFDBEAFE),
        roomCount: 4),
  ];

  // Rooms — V2 names
  static const List<Room> popularRooms = [
    Room(
      id: 1,
      name: 'OasisOverture',
      building: 'Gedung Teknik • Lt 2',
      imageUrl:
          'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?auto=format&fit=crop&q=80&w=400',
      capacity: 30,
      facilities: ['Smart TV', 'AC', 'Proyektor'],
      wifiSpeed: '1 Gbps',
      isFavorite: true,
      status: 'ready',
      buildingId: 'T',
    ),
    Room(
      id: 2,
      name: 'HiddenHaven',
      building: 'Gedung Ekonomi • Lt 3',
      imageUrl:
          'https://images.unsplash.com/photo-1541339907198-e08756ebafe3?auto=format&fit=crop&q=80&w=400',
      capacity: 25,
      facilities: ['Proyektor', 'AC'],
      wifiSpeed: '500 Mbps',
      isFavorite: false,
      status: 'ready',
      buildingId: 'E',
    ),
    Room(
      id: 3,
      name: 'GoldenValley',
      building: 'Gedung MIPA • Lt 1',
      imageUrl:
          'https://images.unsplash.com/photo-1505373877841-8d25f7d46678?auto=format&fit=crop&q=80&w=400',
      capacity: 40,
      facilities: ['Smart TV', 'AC', 'Whiteboard'],
      wifiSpeed: '1 Gbps',
      isFavorite: true,
      status: 'ready',
      buildingId: 'M',
    ),
    Room(
      id: 4,
      name: 'SilverLake',
      building: 'Gedung Teknik • Lt 4',
      imageUrl:
          'https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&q=80&w=400',
      capacity: 20,
      facilities: ['AC', 'Proyektor'],
      wifiSpeed: '500 Mbps',
      isFavorite: false,
      status: 'busy',
      buildingId: 'T',
    ),
    Room(
      id: 5,
      name: 'NeonNode',
      building: 'Gedung Kedokteran • Lt 1',
      imageUrl:
          'https://images.unsplash.com/photo-1517245318725-667755582236?auto=format&fit=crop&q=80&w=400',
      capacity: 35,
      facilities: ['Smart TV', 'AC', 'Proyektor', 'Whiteboard'],
      wifiSpeed: '1 Gbps',
      isFavorite: false,
      status: 'ready',
      buildingId: 'K',
    ),
  ];

  // Bookings
  static const List<Booking> myBookings = [
    Booking(
      id: 774219,
      room: 'OasisOverture',
      time: '08:00 - 10:00',
      date: '17',
      month: 'FEB',
      status: 'Aktif',
      statusColor: Color(0xFF059669),
      statusBgColor: Color(0xFFECFDF5),
      roomId: 1,
      session: '08:00 - 10:00',
    ),
    Booking(
      id: 774220,
      room: 'GoldenValley',
      time: '13:00 - 15:00',
      date: '18',
      month: 'FEB',
      status: 'Akan Datang',
      statusColor: Color(0xFF4F46E5),
      statusBgColor: Color(0xFFEEF2FF),
      roomId: 3,
      session: '13:00 - 15:00',
    ),
  ];
}

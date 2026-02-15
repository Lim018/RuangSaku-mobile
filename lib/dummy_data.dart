import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/building.dart';
import '../models/room.dart';
import '../models/booking.dart';
import 'core/theme/app_colors.dart';

class DummyData {
  DummyData._();

  static const List<Building> buildings = [
    Building(
      name: 'Teknik',
      icon: LucideIcons.cpu,
      roomCount: 12,
      bgColor: AppColors.rose50,
      iconColor: AppColors.rose600,
      borderColor: Color(0xFFFFE4E6),
    ),
    Building(
      name: 'Ekonomi',
      icon: LucideIcons.barChart3,
      roomCount: 8,
      bgColor: Color(0xFFEEF2FF),
      iconColor: AppColors.indigo600,
      borderColor: Color(0xFFE0E7FF),
    ),
    Building(
      name: 'Hukum',
      icon: LucideIcons.scale,
      roomCount: 5,
      bgColor: AppColors.amber50,
      iconColor: AppColors.amber600,
      borderColor: Color(0xFFFEF3C7),
    ),
    Building(
      name: 'Sastra',
      icon: LucideIcons.penTool,
      roomCount: 6,
      bgColor: AppColors.emerald50,
      iconColor: AppColors.emerald600,
      borderColor: Color(0xFFD1FAE5),
    ),
  ];

  static const List<Room> popularRooms = [
    Room(
      id: 101,
      name: 'Lab Robotik',
      building: 'Teknik • Lt 2',
      imageUrl: 'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?auto=format&fit=crop&q=80&w=400',
      capacity: 30,
    ),
    Room(
      id: 102,
      name: 'R. Teori 301',
      building: 'Teknik • Lt 3',
      imageUrl: 'https://images.unsplash.com/photo-1541339907198-e08756ebafe3?auto=format&fit=crop&q=80&w=400',
      capacity: 45,
    ),
    Room(
      id: 103,
      name: 'Cinema Room',
      building: 'Sastra • Lt 1',
      imageUrl: 'https://images.unsplash.com/photo-1505373877841-8d25f7d46678?auto=format&fit=crop&q=80&w=400',
      capacity: 60,
    ),
    Room(
      id: 104,
      name: 'R. Seminar Utama',
      building: 'Ekonomi • Lt 2',
      imageUrl: 'https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&q=80&w=400',
      capacity: 80,
    ),
  ];

  static const List<Booking> myBookings = [
    Booking(
      room: 'Lab Robotik',
      time: 'Besok, 09:00 - 12:00',
      date: '18',
      month: 'FEB',
      status: 'Active',
    ),
    Booking(
      room: 'R. Seminar Utama',
      time: '22 Feb, 13:00 - 15:00',
      date: '22',
      month: 'FEB',
      status: 'Upcoming',
    ),
    Booking(
      room: 'Cinema Room',
      time: '25 Feb, 10:00 - 12:00',
      date: '25',
      month: 'FEB',
      status: 'Upcoming',
    ),
  ];
}

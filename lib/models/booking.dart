class Booking {
  final String room;
  final String time;
  final String date;
  final String month;
  final String status; // 'Active', 'Upcoming', 'Completed'

  const Booking({
    required this.room,
    required this.time,
    required this.date,
    required this.month,
    this.status = 'Upcoming',
  });
}

class Employee {
  final String id;
  final String name;
  final DateTime startDate;
  final bool isActive;

  Employee(
      {required this.id,
      required this.name,
      required this.startDate,
      required this.isActive});

  bool isGreenFlag() {
    DateTime now = DateTime.now();
    DateTime fiveYearsAgo = DateTime(now.year - 5, now.month, now.day);
    return startDate.isBefore(fiveYearsAgo);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/employee.dart';
import '../screens/add_employee.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    super.key,
    required this.employee,
  });
  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: employee.isGreenFlag() && employee.isActive
          ? Colors.greenAccent
          : employee.isActive
              ? Colors.white
              : Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Icon(employee.isActive ? Icons.person_2 : Icons.person_off),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                employee.name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                  'From: ${DateFormat('dd MMM, yyyy').format(employee.startDate)}'),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              InkWell(
                onTap: () {
                  /// TODO: Edit card
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddEmployeeScreen(employee: employee)),
                  );
                },
                child: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  FirebaseFirestore.instance
                      .collection('employees')
                      .doc(employee.id)
                      .delete();
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/employee.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    super.key,
    required this.employee,
    required this.flagGreen,
    required this.id,
  });

  final Employee employee;
  final bool flagGreen;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        // dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        leading: Icon(employee.isActive ? Icons.person_2 : Icons.person_off),
        title: Text(employee.name),
        subtitle: Text(
            'From: ${DateFormat('dd MMM, yyyy').format(employee.startDate)}'),
        tileColor: flagGreen
            ? Colors.greenAccent
            : employee.isActive
                ? Colors.white
                : Colors.grey[200],
        trailing: InkWell(
          onTap: () {
            FirebaseFirestore.instance.collection('employees').doc(id).delete();
          },
          child: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_app/screens/add_employee.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/employee.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.home),
        title: const Text('Employees'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('employees').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('No employees found..'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 4),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot document = snapshot.data!.docs[index];
              final employee = Employee(
                name: document['name'],
                startDate: (document['startDate'] as Timestamp).toDate(),
                isActive: document['isActive'],
              );
              final bool flagGreen =
                  employee.isGreenFlag() && employee.isActive;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: EmployeeCard(
                    employee: employee,
                    flagGreen: flagGreen,
                    document: document),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEmployeeScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    super.key,
    required this.employee,
    required this.flagGreen,
    required this.document,
  });

  final Employee employee;
  final bool flagGreen;
  final DocumentSnapshot<Object?> document;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
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
        trailing: IconButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('employees')
                .doc(document.id)
                .delete();
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

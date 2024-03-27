import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_app/screens/add_employee.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/employee.dart';
import '../widgets/employee_card.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(Icons.deblur),
        actions: [
          IconButton(
              onPressed: () async {
                await launchUrl(Uri.parse(
                  "https://vireshdev.netlify.app",
                ));
              },
              icon: const Icon(Icons.info_outline)),
        ],
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
                  id: document.id,
                ),
              );
            },
          );
        },
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const InfoWidget(
              color: Colors.white,
              text: 'Active',
            ),
            InfoWidget(
              color: Colors.grey[200]!,
              text: 'Inactive',
            ),
            const InfoWidget(
              color: Colors.greenAccent,
              text: 'Staff',
            ),
          ],
        ),
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

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    super.key,
    required this.color,
    required this.text,
  });

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(1, 1),
              ),
            ], borderRadius: BorderRadius.circular(5), color: color),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(text)
        ],
      ),
    );
  }
}

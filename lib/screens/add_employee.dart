import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_app/model/employee.dart';
import 'package:employee_app/widgets/validators.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_date_picker.dart';
import '../widgets/custom_text_form_field.dart';

class AddEmployeeScreen extends StatefulWidget {
  final Employee? employee;
  const AddEmployeeScreen({Key? key, this.employee}) : super(key: key);

  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime startDate = DateTime.now();
  bool isActive = true;

  @override
  void initState() {
    if (widget.employee != null) {
      _nameController.text = widget.employee!.name;
      _dateController.text =
          '${widget.employee!.startDate.day}/${widget.employee!.startDate.month}/${widget.employee!.startDate.year}';
      isActive = widget.employee!.isActive;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                validator: isValidName,
                controller: _nameController,
                hint: 'First Last',
                label: 'Full Name',
                icon: Icons.person,
              ),
              const SizedBox(height: 20.0),
              CustomDatePicker(
                validator: isValidDate,
                controller: _dateController,
                icon: Icons.calendar_month,
                hint: 'DD/MM/YYY',
                label: 'Joining date',
              ),
              const SizedBox(height: 10.0),
              SwitchListTile(
                title: const Text('Active'),
                value: isActive,
                onChanged: (value) {
                  setState(() {
                    isActive = value;
                  });
                },
              ),
              const Spacer(),
              SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      startDate =
                          DateFormat('dd/MM/yyyy').parse(_dateController.text);
                      // Add employee to Firestore
                      if (widget.employee != null) {
                        FirebaseFirestore.instance
                            .collection('employees')
                            .doc(widget.employee!.id)
                            .update({
                          'name': _nameController.text,
                          'startDate': startDate,
                          'isActive': isActive,
                        });
                      } else {
                        FirebaseFirestore.instance.collection('employees').add({
                          'name': _nameController.text,
                          'startDate': startDate,
                          'isActive': isActive,
                        });
                      }

                      // Navigate back to the employee screen
                      Navigator.pop(context);
                    }
                    // startDate =
                    //     DateFormat('dd/MM/yyyy').parse(_dateController.text);
                    // // Add employee to Firestore
                    // FirebaseFirestore.instance.collection('employees').add({
                    //   'name': _nameController.text,
                    //   'startDate': startDate,
                    //   'isActive': isActive,
                    // });

                    // // Navigate back to the employee screen
                    // Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  child: Text(widget.employee != null
                      ? 'Update Employee'
                      : 'Add Employee'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}

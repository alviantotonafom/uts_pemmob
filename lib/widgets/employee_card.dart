import 'package:flutter/material.dart';

class EmployeeCard extends StatelessWidget {
  final String name;
  final String status;
  final String photo;
  final Function(String) onStatusChanged;

  EmployeeCard({
    required this.name,
    required this.status,
    required this.photo,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(photo),
        ),
        title: Text(name),
        subtitle: Text('Status: $status'),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            onStatusChanged(status == 'Aktif' ? 'Tidak Aktif' : 'Aktif');
          },
        ),
      ),
    );
  }
}

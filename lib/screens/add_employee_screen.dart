import 'package:flutter/material.dart';

class AddEmployeeScreen extends StatefulWidget {
  final Function(Map<String, String>) addEmployee;

  AddEmployeeScreen({required this.addEmployee});

  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _nameController = TextEditingController();
  final _statusController = TextEditingController();

  void _submit() {
    final name = _nameController.text;
    final status = _statusController.text;

    if (name.isNotEmpty && status.isNotEmpty) {
      // Tidak menambahkan gambar
      widget.addEmployee({
        'name': name,
        'status': status,
        'photo': '', // Tidak ada foto
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Karyawan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama Karyawan'),
            ),
            TextField(
              controller: _statusController,
              decoration:
                  InputDecoration(labelText: 'Status (Aktif/Tidak Aktif)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Tambah Karyawan'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'add_employee_screen.dart';
import '../widgets/employee_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> employees = [
    {'name': 'Ali', 'status': 'Aktif', 'photo': 'assets/ali.avif'},
    {'name': 'Budi', 'status': 'Tidak Aktif', 'photo': 'assets/budi.avif'},
    {'name': 'Citra', 'status': 'Aktif', 'photo': 'assets/citra.avif'},
  ];

  String searchQuery = '';

  void _addEmployee(Map<String, String> newEmployee) {
    setState(() {
      employees.add(newEmployee);
    });
  }

  @override
  Widget build(BuildContext context) {
    final activeEmployees =
        employees.where((employee) => employee['status'] == 'Aktif').length;
    final inactiveEmployees = employees.length - activeEmployees;

    final filteredEmployees = employees.where((employee) {
      return employee['name']!
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Monitoring Karyawan WFH'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: EmployeeSearchDelegate(employees),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Karyawan Aktif: $activeEmployees\nKaryawan Tidak Aktif: $inactiveEmployees',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredEmployees.length,
              itemBuilder: (context, index) {
                // Jika tidak ada gambar (photo kosong), tampilkan gambar default
                String photo = filteredEmployees[index]['photo']!.isEmpty
                    ? 'assets/empty.avif' // Gambar placeholder atau ikon default
                    : filteredEmployees[index]['photo']!;

                return EmployeeCard(
                  name: filteredEmployees[index]['name']!,
                  status: filteredEmployees[index]['status']!,
                  photo: photo,
                  onStatusChanged: (newStatus) {
                    setState(() {
                      filteredEmployees[index]['status'] = newStatus;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddEmployeeScreen(addEmployee: _addEmployee),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class EmployeeSearchDelegate extends SearchDelegate {
  final List<Map<String, String>> employees;

  EmployeeSearchDelegate(this.employees);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = employees.where((employee) {
      return employee['name']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]['name']!),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _age = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Age Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                suffixIcon: IconButton(
                  icon: Icon(Icons.date_range),
                  onPressed: () => _selectDate(context),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _calculateAge(),
              child: Text('Calculate Age'),
            ),
            SizedBox(height: 16.0),
            Text(
              _age,
              style: TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked!= null && picked!= _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }

  void _calculateAge() {
    final DateTime now = DateTime.now();
    final DateTime birthDate = DateTime.parse(_dateController.text);
    final int years = now.year - birthDate.year;
    final int months = now.month - birthDate.month;
    final int days = now.day - birthDate.day;

    setState(() {
      _age = 'Age: $years years, $months months, and $days days';
    });
  }
}
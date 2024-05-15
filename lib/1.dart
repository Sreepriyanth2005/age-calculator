import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  String _age = '';

  Future<void> _calculateAge() async {
    final response = await http.post(
      Uri.parse('https://your-backend-url.com/calculate-age'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'dateOfBirth': _dateController.text}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _age = jsonDecode(response.body)['age'];
      });
    } else {
      setState(() {
        _age = 'Error: ${response.statusCode}';
      });
    }
  }

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
              decoration: InputDecoration(
                labelText: 'Date of Birth',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _calculateAge,
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
}
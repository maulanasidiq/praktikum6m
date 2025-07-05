import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // ← Tambahkan ini
import 'agenda_list.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // ← Wajib untuk async sebelum runApp
  await initializeDateFormatting(
      'id_ID', null); // ← Inisialisasi format lokal Indonesia
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const AgendaList(),
    );
  }
}

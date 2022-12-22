import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:walkcity/src/preferences/preferences.dart';
import 'package:http/http.dart' as http;

class ShowSheet extends StatefulWidget {
  final idSite;

  const ShowSheet({super.key, this.idSite});

  @override
  State<ShowSheet> createState() => _ShowSheetState();
}

class _ShowSheetState extends State<ShowSheet> {
  String comment = "";
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        side:
            const BorderSide(width: 2, color: Color.fromARGB(255, 66, 66, 66)),
        borderRadius: BorderRadius.circular(12),
      ),
      height: 35,
      minWidth: 100,
      child: const Text(
        "Comentar",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: () {
        _mysheet(context);
      },
    );
  }

  _mysheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            height: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  autofocus: true,
                  style: const TextStyle(color: Colors.black),
                  autocorrect: false,
                  textInputAction: TextInputAction.send,
                  keyboardType: TextInputType.text,
                  decoration: _buildDecoration(
                    hintText: 'Comentar...',
                  ),
                  onChanged: (value) => comment = value,
                ),
                IconButton(
                    onPressed: () async {
                      final DateTime now = DateTime.now();
                      final formatter = now.toString();
                      final dateNow = formatter.substring(0, 11);
                      const String apikey =
                          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ';

                      final Map<String, dynamic> data = {
                        "created_at": dateNow,
                        "comentario": comment,
                        "id_sitio": widget.idSite,
                        "id_user": Preferences.identificador
                      };

                      Map<String, String> header = {
                        'apikey': apikey,
                        'Content-Type': 'application/json',
                        'Prefer': 'return=minimal'
                      };
print(data);
                      const url =
                          'https://kowzlncfrrqjcojxapmv.supabase.co/rest/v1/Comentario';
                      final uri = Uri.parse(url);
                      final res = await http.post(uri,
                          body: json.encode(data), headers: header);
                      final body = res.body;
                      print(body);
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
          ),
        );
      },
    );
  }

  InputDecoration _buildDecoration({
    final String? hintText,
  }) {
    return InputDecoration(
      fillColor: const Color.fromARGB(255, 240, 240, 240),
      hintStyle: const TextStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.transparent)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.transparent)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.transparent)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      hintText: hintText,
      filled: true,
    );
  }
}

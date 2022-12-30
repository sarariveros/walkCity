import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:walkcity/src/preferences/preferences.dart';

import '../widgets/index.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ComentsPage extends StatefulWidget {
  final idSite;

  const ComentsPage({super.key, this.idSite});

  @override
  State<ComentsPage> createState() => _ComentsPageState();
}

class _ComentsPageState extends State<ComentsPage> {
  String apikey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ';
  String autorization =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ';

  List<dynamic> comments = [];

  String comment = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 70, 10, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Comentarios (${comments.length})',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 220,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: comments.length,
                  itemBuilder: (BuildContext context, int i) {
                    if (comments[i]["id_user"] == Preferences.identificador) {
                      return MyComment(info: comments[i]);
                    } else {
                      return Comment(info: comments[i]);
                    }
                  },
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    autocorrect: false,
                    textInputAction: TextInputAction.send,
                    keyboardType: TextInputType.text,
                    decoration: _buildDecoration(
                      hintText: 'Comentar...',
                    ),
                    onChanged: (value) => comment = value,
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      if(comment == "") return;
                      createComment();
                    },
                    icon: const Icon(Icons.send))
              ],
            )
          ],
        ),
      ),
    );
  }

  void getData() async {
    Map<String, String> header = {
      'apikey': apikey,
      'Authorization': autorization,
      'Content-Type': 'application/json',
      'Prefer': 'return=minimal'
    };

    final url =
        'https://kowzlncfrrqjcojxapmv.supabase.co/rest/v1/Comentario?id_sitio=eq.${widget.idSite.id}';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers: header);
    final body = res.body;
    final data = jsonDecode(body);

    setState(() {
      comments = data;
    });
  }

  void createComment() async {
    Map<String, String> header = {
      'apikey': apikey,
      'Content-Type': 'application/json',
      'Prefer': 'return=minimal'
    };

    final Map<String, dynamic> data = {
      "hora": DateFormat('KK:mm:ss a').format(DateTime.now()),
      "comentario": comment,
      "id_sitio": widget.idSite.id,
      "id_user": Preferences.identificador
    };

    const url = 'https://kowzlncfrrqjcojxapmv.supabase.co/rest/v1/Comentario';
    final uri = Uri.parse(url);
    await http.post(uri, body: json.encode(data), headers: header);
    comment = "";
    getData();
  }
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

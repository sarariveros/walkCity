import 'dart:convert';

import 'package:flutter/material.dart';

import '../widgets/index.dart';
import 'package:http/http.dart' as http;

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

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 70, 10, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Comentarios (${comments.length})',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ShowSheet(idSite: widget.idSite.id)
                ],
              ),
              SingleChildScrollView(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: comments.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Comment(info: comments[i]);
                  },
                ),
              )
            ],
          ),
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
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:walkcity/src/preferences/preferences.dart';
import 'package:walkcity/src/styles/style.dart';

import '../widgets/index.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class ComentsPage extends StatefulWidget {
  final idSite;

  const ComentsPage({super.key, this.idSite});

  @override
  State<ComentsPage> createState() => _ComentsPageState();
}

class _ComentsPageState extends State<ComentsPage>
    with TickerProviderStateMixin {
  String apikey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ';
  String autorization =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ';

  List<dynamic> comments = [];

  final _commentController = TextEditingController();

  Widget _buildTextComposer() {
    return Row(
      children: [
        Flexible(
          child: TextField(
            controller: _commentController,
            style: const TextStyle(color: Colors.black),
            textInputAction: TextInputAction.send,
            keyboardType: TextInputType.text,
            decoration: Styles.buildDecoration(
              hintText: 'Comentar...',
            ),
          ),
        ),
        IconButton(
            onPressed: () async {
              if (_commentController.text == "") return;
              createComment();
            },
            icon: Icon(
              Icons.send,
              color: Styles.firstColor,
            ))
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Comentarios (${comments.length})',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
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
          const Divider(
            height: 1.0,
          ),
          Container(
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 20,
                left: 10,
                right: 10,
              ),
              child: _buildTextComposer())
        ],
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
      "comentario": _commentController.text,
      "id_sitio": widget.idSite.id,
      "id_user": Preferences.identificador
    };

    const url = 'https://kowzlncfrrqjcojxapmv.supabase.co/rest/v1/Comentario';
    final uri = Uri.parse(url);
    await http.post(uri, body: json.encode(data), headers: header);

    _commentController.clear();

    getData();
  }
}

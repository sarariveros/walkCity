import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


// ignore: camel_case_types
class Comment extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final info;

  const Comment({super.key, required this.info});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  dynamic dataUser = {};
  String apikey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ';
  String autorization =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ';

  @override
  void initState() {
    super.initState();

    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromARGB(255, 206, 206, 206), width: 1))),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(
                  dataUser["image"] == null
                      ? "https://cultura-sorda.org/wp-content/uploads/2015/02/Usuario-Vacio-300x300.png"
                      : 'https://kowzlncfrrqjcojxapmv.supabase.co/storage/v1/object/public/profile.images/data/user/0/com.example.walkcity/cache/${dataUser["image"]}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dataUser["nombre"] ?? " ",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                child: Text(widget.info["created_at"]),
              ),
              Text(
                widget.info["comentario"],
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w100,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void getDataUser() async {
    Map<String, String> header = {
      'apikey': apikey,
      'Authorization': autorization,
      'Content-Type': 'application/json',
      'Prefer': 'return=minimal'
    };

    final url =
        'https://kowzlncfrrqjcojxapmv.supabase.co/rest/v1/DatosUsuario?usuario=eq.${widget.info["id_user"]}';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers: header);
    final body = res.body;
    final data = jsonDecode(body);
    setState(() {
      dataUser = data[0];
    });
  }
}

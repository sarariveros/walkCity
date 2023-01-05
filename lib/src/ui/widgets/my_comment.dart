import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:walkcity/src/styles/style.dart';

// ignore: camel_case_types
class MyComment extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final info;

  const MyComment({super.key, required this.info});

  @override
  State<MyComment> createState() => _MyCommentState();
}

class _MyCommentState extends State<MyComment> {
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Styles.firstColor),
            width: MediaQuery.of(context).size.width - 150,
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dataUser["nombre"] ?? " ",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.info["hora"],
                      style: const TextStyle(fontSize: 10),
                    )
                  ],
                ),
                Text(
                  widget.info["comentario"],
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w100,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                image: NetworkImage(
                  dataUser["image"] == null || dataUser["image"] == ""
                      ? "https://cultura-sorda.org/wp-content/uploads/2015/02/Usuario-Vacio-300x300.png"
                      : 'https://kowzlncfrrqjcojxapmv.supabase.co/storage/v1/object/public/profile.images/data/user/0/com.example.walkcity/cache/${dataUser["image"]}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
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

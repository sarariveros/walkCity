import 'package:flutter/material.dart';

class ShowSheet extends StatelessWidget {
  const ShowSheet({super.key});

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
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20)
        )
      ),
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
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.send))
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

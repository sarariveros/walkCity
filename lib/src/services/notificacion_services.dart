import 'package:flutter/material.dart';
import 'package:walkcity/src/styles/style.dart';

class NotificationServices {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message, IconData icono) {
    final snackBar = SnackBar(
        backgroundColor: Styles.secondColor,
        duration: const Duration(milliseconds: 240),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icono,
              color: Colors.black,
            ),

            // (type == 1)
            //     ? const Icon(
            //         Icons.favorite_outlined,
            //         color: Colors.black,
            //       )
            //     : const Icon(
            //         Icons.heart_broken,
            //         color: Colors.black,
            //       ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ));

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}

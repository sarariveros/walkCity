import 'package:flutter/material.dart';
import 'package:walkcity/src/styles/style.dart';

class NotificationServices {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message, int type) {
    final snackBar = SnackBar(
        backgroundColor: Styles.firstColor,
        duration: const Duration(milliseconds: 240),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (type == 1)
                ? const Icon(
                    Icons.favorite_outlined,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.heart_broken,
                    color: Colors.white,
                  ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(message),
            )
          ],
        ));

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}

import 'package:flutter/material.dart';
import 'package:walkcity/src/styles/style.dart';

class AlertDialogD {
  // ignore: unused_element
  static showAlertDialog(BuildContext context, String title, String info,
      bool img, bool typeRoute, String ruta, String rutaText) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: SizedBox(
            height: 370,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child: Image.network(
                        img
                            ? "https://cdn.icon-icons.com/icons2/1506/PNG/512/emblemdefault_103756.png"
                            : "https://cdn-icons-png.flaticon.com/512/148/148766.png",
                        width: 100),
                  ),
                  Text(
                    info,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: 350.0,
                    child: MaterialButton(
                      onPressed: () {
                        if (typeRoute) {
                          Navigator.pushNamed(
                            context,
                            ruta,
                          );
                        } else {
                          Navigator.pop(context, false);
                        }
                      },
                      color: Styles.firstColor,
                      child: Text(
                        rutaText,
                        style: TextStyle(color: Styles.fouthColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

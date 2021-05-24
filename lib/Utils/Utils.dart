import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Data/CodeArray.dart';

read(TextEditingController controller) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'country_code';
  final value = prefs.getString(key) ?? '0';
  if (value != '0') {
    controller.text = value;
  }
}

save(String code) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'country_code';
  prefs.setString(key, code);
}

openWhatsapp(
    BuildContext context, final String phone, final String code) async {
  save(code);
  String url = "https://api.whatsapp.com/send?phone=$code$phone&text=";
  final String encoded = Uri.encodeFull(url);
  if (await canLaunch(encoded)) {
    await launch(encoded);
  } else {
    showSnackBar(context, 'Some unexpected error occurred');
    throw 'Cannot open $encoded';
  }
}

showSnackBar(BuildContext context, String data) {
  if (Platform.isIOS) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) => CupertinoAlertDialog(
              content: Text(data),
              title: Text(
                'Alert',
                style: TextStyle(color: Colors.redAccent),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text(
                    'OK',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.greenAccent),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                )
              ],
            ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        data,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 57, 62, 70),
      duration: Duration(seconds: 3),
    ));
  }
}

openerDetails(BuildContext context, TextEditingController controller,
    TextEditingController codeController) {
  String phone = controller.text;
  String code = codeController.text;
  if (phone == '') {
    showSnackBar(context, 'Enter Number');
  } else if (phone.length < 10) {
    showSnackBar(context, 'Invalid Number');
  } else if (code == '') {
    showSnackBar(context, 'Enter Country Code');
  } else if (!codeArray.contains(code)) {
    showSnackBar(context, 'Country Code doesn\'t exist');
  } else {
    openWhatsapp(context, phone, code);
  }
}

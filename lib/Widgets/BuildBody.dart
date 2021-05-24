import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../Utils/Utils.dart';

Widget buildBody(BuildContext context, TextEditingController controller,
    TextEditingController codeController, BannerAd banner) {
  return Column(
    children: <Widget>[
      SizedBox(
        height: 40,
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width - 120,
        padding: EdgeInsets.all(30),
        child: Image.asset(
          'assets/app_icon/app_logo.png',
          fit: BoxFit.contain,
        ),
      ),
      SizedBox(
        height: 40,
      ),
      Container(
        child: Text(
          'Enter number with country code',
          style: TextStyle(
            color: Platform.isIOS
                ? CupertinoTheme.of(context).primaryContrastingColor
                : Theme.of(context).accentColor,
            fontSize: 18,
          ),
        ),
        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 30),
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Container(
            child: Platform.isIOS
                ? CupertinoTextField(
                    controller: codeController,
                    placeholder: 'Code',
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            CupertinoTheme.of(context).primaryContrastingColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      color: CupertinoTheme.of(context).primaryContrastingColor,
                    ),
                    maxLength: 3,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                    keyboardType: TextInputType.phone,
                    cursorColor:
                        CupertinoTheme.of(context).primaryContrastingColor,
                  )
                : TextField(
                    controller: codeController,
                    textAlignVertical: TextAlignVertical.center,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Code',
                      focusColor: Theme.of(context).accentColor,
                      counter: Text(''),
                      fillColor: Theme.of(context).accentColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                          width: 2,
                        ),
                      ),
                    ),
                    maxLength: 3,
                    keyboardType: TextInputType.phone,
                    cursorColor: Theme.of(context).accentColor,
                  ),
            margin: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            width: 80,
          ),
          Container(
            child: Platform.isIOS
                ? CupertinoTextField(
                    placeholder: 'Number',
                    controller: controller,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            CupertinoTheme.of(context).primaryContrastingColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      color: CupertinoTheme.of(context).primaryContrastingColor,
                    ),
                    maxLength: 10,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                    keyboardType: TextInputType.phone,
                    cursorColor:
                        CupertinoTheme.of(context).primaryContrastingColor,
                  )
                : TextField(
                    controller: controller,
                    textAlignVertical: TextAlignVertical.center,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Number',
                      counter: Text(''),
                      focusColor: Theme.of(context).accentColor,
                      fillColor: Color.fromARGB(255, 57, 62, 70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                          width: 2,
                        ),
                      ),
                    ),
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    cursorColor: Theme.of(context).accentColor,
                  ),
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width - 150,
          ),
        ],
      ),
      SizedBox(
        height: 100,
      ),
      Platform.isIOS
          ? CupertinoButton(
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
              onPressed: () {
                openerDetails(context, controller, codeController);
              },
              color: CupertinoTheme.of(context).primaryContrastingColor,
              padding: EdgeInsets.all(15),
              borderRadius: BorderRadius.circular(40),
            )
          : MaterialButton(
              onPressed: () {
                openerDetails(context, controller, codeController);
              },
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
              color: Theme.of(context).accentColor,
              padding: EdgeInsets.all(15),
              shape: CircleBorder(),

            ),
      SizedBox(
        height: 10,
      ),
      Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: AdWidget(
              ad: banner,
            ),
            height: 90,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
          ),
        ),
      ),
    ],
  );
}

import 'package:direct_message/core/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resize/resize.dart';

void showSnackBar(String message) =>
    ScaffoldMessenger.of(globalContext).showSnackBar(
      SnackBar(
        padding: EdgeInsets.symmetric(
          horizontal: 15.sp,
          vertical: 5.sp,
        ),
        dismissDirection: DismissDirection.vertical,
        content: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 40.sp,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.close,
                size: 25.sp,
                color: Colors.redAccent,
              ),
              Gap(15.sp),
              Expanded(
                child: Text(
                  message,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

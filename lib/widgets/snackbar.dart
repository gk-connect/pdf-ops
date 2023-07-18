import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

const errorSnackMsgMinFile = SnackBar(
  content: Text('Minimum 2 pdf required to merge'),
  backgroundColor: Vx.red600,
  elevation: 10,
  behavior: SnackBarBehavior.floating,
  margin: EdgeInsets.all(5),
);

const mergeSaveSuccessfull = SnackBar(
  content: Text('File saved successfully'),
  backgroundColor: Vx.green700,
  elevation: 10,
  behavior: SnackBarBehavior.floating,
  margin: EdgeInsets.all(5),
);

// import 'dart:io';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils {
//   static void showOkCancelAlertDialog({
//     BuildContext context,
//     String message,
//     String okButtonTitle,
//     String cancelButtonTitle,
//     Function cancelButtonAction,
//     Function okButtonAction,
//     bool isCancelEnable = true,
//   }) {
//     // flutter defined function
//     showDialog(
//       barrierDismissible: isCancelEnable,
//       context: context,
//       builder: (context) {
//         if (Platform.isIOS) {
//           return _showOkCancelCupertinoAlertDialog(
//               context,
//               message,
//               okButtonTitle,
//               cancelButtonTitle,
//               okButtonAction,
//               isCancelEnable,
//               cancelButtonAction);
//         } else {
//           return _showOkCancelMaterialAlertDialog(
//               context,
//               message,
//               okButtonTitle,
//               cancelButtonTitle,
//               okButtonAction,
//               isCancelEnable,
//               cancelButtonAction);
//         }
//       },
//     );
//   }

//   static void showAlertDialog(BuildContext context, String message) {
//     // flutter defined function
//     showDialog(
//       context: context,
//       builder: (context) {
//         if (Platform.isIOS) {
//           return _showCupertinoAlertDialog(context, message);
//         } else {
//           return _showMaterialAlertDialog(context, message);
//         }
//       },
//     );
//   }

//   static void showAlertDialogWithCustomeAction(
//       BuildContext context, String message, List<Widget> actions) {
//     // flutter defined function
//     showDialog(
//       context: context,
//       builder: (context) {
//         if (Platform.isIOS) {
//           return _showCupertinoAlertDialog(context, message, actions: actions);
//         } else {
//           return _showMaterialAlertDialog(context, message, actions: actions);
//         }
//       },
//     );
//   }

//   static CupertinoAlertDialog _showCupertinoAlertDialog(
//       BuildContext context, String message,
//       List<Widget> actions) {
//     return CupertinoAlertDialog(
//       title: Text("Product Management Demo"),
//       content: Text(message),
//       actions: _actions(context) : actions,
//     );
//   }

//   static AlertDialog _showMaterialAlertDialog(
//       BuildContext context, String message, List<Widget> actions) {
//     return AlertDialog(
//       title: Text("Product Management Demo"),
//       content: Text(
//         message,
//         style: TextStyle(color: Colors.black),
//       ),
//       actions: actions == null ? _actions(context) : actions,
//     );
//   }

//   static AlertDialog _showOkCancelMaterialAlertDialog(
//       BuildContext context,
//       String message,
//       String okButtonTitle,
//       String? cancelButtonTitle,
//       Function okButtonAction,
//       bool isCancelEnable,
//       Function? cancelButtonAction) {
//     return AlertDialog(
//       title: Text("Product Management Demo"),
//       content: Text(message),
//       actions: _okCancelActions(
//         context,
//         okButtonTitle,
//         cancelButtonTitle,
//         okButtonAction,
//         isCancelEnable,
//         cancelButtonAction,
//       ),
//     );
//   }

//   static CupertinoAlertDialog _showOkCancelCupertinoAlertDialog(
//     BuildContext context,
//     String message,
//     String okButtonTitle,
//     String cancelButtonTitle,
//     Function okButtonAction,
//     bool isCancelEnable,
//     Function cancelButtonAction,
//   ) {
//     return CupertinoAlertDialog(
//         title: Text(Localization.of(context).appName),
//         content: Text(message),
//         actions: isCancelEnable
//             ? _okCancelActions(
//                 context: context,
//                 okButtonTitle: okButtonTitle,
//                 cancelButtonTitle: cancelButtonTitle,
//                 okButtonAction: okButtonAction,
//                 isCancelEnable: isCancelEnable,
//                 cancelButtonAction: cancelButtonAction,
//               )
//             : _okAction(
//                 context: context,
//                 okButtonAction: okButtonAction,
//                 okButtonTitle: okButtonTitle));
//   }

//   static List<Widget> _actions(BuildContext context) {
//     return <Widget>[
//       Platform.isIOS
//           ? CupertinoDialogAction(
//               child: Text("Ok"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             )
//           : ElevatedButton(
//               child: Text("Ok"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//     ];
//   }

//   static List<Widget> _okCancelActions(
//     BuildContext context,
//     String okButtonTitle,
//     String? cancelButtonTitle,
//     Function okButtonAction,
//     bool isCancelEnable,
//     Function? cancelButtonAction,
//   ) {
//     return <Widget>[
//       if (cancelButtonTitle != null)
//         if (Platform.isIOS)
//           CupertinoDialogAction(
//             isDestructiveAction: true,
//             child: Text(cancelButtonTitle),
//             onPressed: cancelButtonAction == null
//                 ? () {
//                     Navigator.of(context).pop();
//                   }
//                 : () {
//                     Navigator.of(context).pop();
//                     cancelButtonAction();
//                   },
//           )
//         else
//           ElevatedButton(
//             child: Text(cancelButtonTitle),
//             onPressed: cancelButtonAction == null
//                 ? () {
//                     Navigator.of(context).pop();
//                   }
//                 : () {
//                     Navigator.of(context).pop();
//                     cancelButtonAction();
//                   },
//           ),
//       Platform.isIOS
//           ? CupertinoDialogAction(
//               child: Text(okButtonTitle),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 okButtonAction();
//               },
//             )
//           : ElevatedButton(
//               child: Text(okButtonTitle),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 okButtonAction();
//               },
//             ),
//     ];
//   }

//   static List<Widget> _okAction(
//       BuildContext context, String okButtonTitle, Function okButtonAction) {
//     return <Widget>[
//       Platform.isIOS
//           ? CupertinoDialogAction(
//               child: Text(okButtonTitle),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 okButtonAction();
//               },
//             )
//           : ElevatedButton(
//               child: Text(okButtonTitle),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 okButtonAction();
//               },
//             ),
//     ];
//   }

  static SnackBar displaySnackBar(String message) {
    return SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
    );
  }
}

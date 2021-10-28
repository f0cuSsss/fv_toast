library fv_toast;

import 'dart:async';

// import 'package:custom_toast/toast_animation.dart';
import 'package:flutter/material.dart';

class ToastUtils {
  static late Timer toastTimer;
  static late OverlayEntry _overlayEntry;

  static void showCustomToast(BuildContext context, String message) {
    if (!toastTimer.isActive && Overlay.of(context) != null) {
      _overlayEntry = createOverlayEntry(context, message);
      Overlay.of(context)!.insert(_overlayEntry);
      toastTimer = Timer(
        const Duration(seconds: 2),
        () {
          _overlayEntry.remove();
        },
      );
    }
  }

  static OverlayEntry createOverlayEntry(BuildContext context, String message) {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0,
        width: MediaQuery.of(context).size.width - 20,
        left: 10,
        child: Material(
          elevation: 10.0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 10),
            decoration: BoxDecoration(
                color: const Color(0xffe53e3f),
                borderRadius: BorderRadius.circular(10)),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                message,
                textAlign: TextAlign.center,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class ToastMessageAnimation extends StatelessWidget {
//   final Widget child;

//   ToastMessageAnimation(this.child);

//   @override
//   Widget build(BuildContext context) {
//     final tween = MultiTrackTween([
//       Track("translateY")
//           .add(
//             Duration(milliseconds: 250),
//             Tween(begin: -100.0, end: 0.0),
//             curve: Curves.easeOut,
//           )
//           .add(Duration(seconds: 1, milliseconds: 250),
//               Tween(begin: 0.0, end: 0.0))
//           .add(Duration(milliseconds: 250),
//               Tween(begin: 0.0, end: -100.0),
//               curve: Curves.easeIn),
//       Track("opacity")
//           .add(Duration(milliseconds: 500),
//               Tween(begin: 0.0, end: 1.0))
//           .add(Duration(seconds: 1),
//               Tween(begin: 1.0, end: 1.0))
//           .add(Duration(milliseconds: 500),
//               Tween(begin: 1.0, end: 0.0)),
//     ]);

//     return ControlledAnimation(
//       duration: tween.duration,
//       tween: tween,
//       child: child,
//       builderWithChild: (context, child, animation) => Opacity(
//         opacity: animation["opacity"],
//         child: Transform.translate(
//             offset: Offset(0, animation["translateY"]),
//                     child: child),
//       ),
//     );
//   }
// }
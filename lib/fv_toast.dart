library fv_toast;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

enum ToastStatuses {
  success,
  error,
  message,
}

class FvToast {
  final BuildContext context;
  FvToast(this.context);

  static Timer _toastTimer = Timer(const Duration(seconds: 0), () {});
  static OverlayEntry? _overlayEntry;
  static FvToast of(BuildContext context) => FvToast(context);

  void showSuccess() {
    show(ToastStatuses.success, 'Success!');
  }

  void showError() {
    show(ToastStatuses.error, 'Error!');
  }

  void showMessage(String message) {
    show(ToastStatuses.message, message);
  }

  void show(ToastStatuses toastType, String message) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }
    _toastTimer.cancel();

    if (!_toastTimer.isActive && Overlay.of(context) != null) {
      switch (toastType) {
        case ToastStatuses.success:
          _overlayEntry = buildCenterOverlay(
            FeatherIcons.checkCircle,
            message,
            textColor: const Color(0xFF0C972A),
          );
          break;
        case ToastStatuses.error:
          _overlayEntry = buildCenterOverlay(
            FeatherIcons.xCircle,
            message,
            textColor: const Color(0xFFC71D11),
          );
          break;
        case ToastStatuses.message:
          _overlayEntry = buildMessageOverlay(message);
          break;
        default:
      }

      if (_overlayEntry != null) {
        Overlay.of(context)!.insert(_overlayEntry!);
        _toastTimer = Timer(
          const Duration(seconds: 2),
          () {
            _overlayEntry!.remove();
            _overlayEntry = null;
          },
        );
      }
    }
  }

  OverlayEntry buildCenterOverlay(
    IconData? icon,
    String message, {
    Color textColor = Colors.black,
    Color backgroundColor = Colors.white,
  }) {
    final mq = MediaQuery.of(context);
    return OverlayEntry(
      builder: (context) => Positioned(
        top: icon != null ? mq.size.height * 0.45 : 50,
        width: mq.size.width,
        child: ToastAnimation(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            width: double.infinity,
            child: Center(
              child: Material(
                elevation: icon != null ? 20.0 : 2,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: icon != null ? 100 : null,
                  width: icon != null ? 100 : mq.size.width * 0.8,
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 13,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      icon == null
                          ? const SizedBox()
                          : Icon(
                              icon,
                              size: 50,
                              color: textColor,
                            ),
                      SizedBox(height: icon == null ? 0 : 5.0),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          overflow: TextOverflow.clip,
                          fontSize: 18,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  OverlayEntry buildMessageOverlay(
    String message, {
    Color textColor = Colors.black,
    Color backgroundColor = Colors.white,
    AxisDirection position = AxisDirection.up,
  }) {
    final mq = MediaQuery.of(context);
    return OverlayEntry(
      builder: (context) => Positioned(
        top: position == AxisDirection.up ? 50.0 : null,
        bottom: position == AxisDirection.down ? 50.0 : null,
        width: mq.size.width - 20,
        left: 10,
        child: ToastAnimation(
          child: Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 13, bottom: 10),
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ToastAnimation extends StatefulWidget {
  const ToastAnimation({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<ToastAnimation> createState() => _ToastAnimationState();
}

class _ToastAnimationState extends State<ToastAnimation>
    with TickerProviderStateMixin {
  late Animation _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animationController,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

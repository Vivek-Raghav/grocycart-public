import 'dart:async';
import 'package:flutter/material.dart';

class TaskAccomplishedScreen extends StatelessWidget {
  final String message;

  const TaskAccomplishedScreen({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: size.height * 0.25,
            width: size.width,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 100,
                ),
                const SizedBox(height: 20),
                Text(
                  message,
                  style: const TextStyle(color: Colors.black, fontSize: 24),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskAccomplishedOverlay extends StatefulWidget {
  final String message;

  const TaskAccomplishedOverlay({Key? key, required this.message})
      : super(key: key);

  @override
  _TaskAccomplishedOverlayState createState() =>
      _TaskAccomplishedOverlayState();
}

class _TaskAccomplishedOverlayState extends State<TaskAccomplishedOverlay> {
  bool _showOverlay = false;

  @override
  void initState() {
    super.initState();
    _showOverlay = true;
    _hideOverlay();
  }

  void _hideOverlay() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showOverlay = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showOverlay
        ? Stack(
            children: [
              IgnorePointer(
                child: TaskAccomplishedScreen(message: widget.message),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}

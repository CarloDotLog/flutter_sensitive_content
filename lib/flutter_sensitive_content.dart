library flutter_sensitive_content;

import 'package:flutter/widgets.dart';

class SensitiveContent extends StatefulWidget {
  /// Protect you sensitive content with SensitiveContent widget.
  /// It listen for AppLifecycle states, when the app goes in background switch
  /// from child content to publicContent content.
  const SensitiveContent(
      {Key? key, required this.child, required this.publicContent})
      : super(key: key);

  final Widget child;
  final Widget publicContent;

  @override
  State<SensitiveContent> createState() => _SensitiveContentState();
}

class _SensitiveContentState extends State<SensitiveContent>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  AppLifecycleState? _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("AppLifecycleState: $state");
    setState(() {
      _notification = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: (AppLifecycleState.paused == _notification ||
            AppLifecycleState.inactive == _notification)
            ? widget.publicContent
            : widget.child);
  }
}


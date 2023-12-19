import 'package:flutter/material.dart';
import 'lazy_indexed_stack.dart';

/// Widget to handle sensitive content and public content with lifecycle awareness.
class SensitiveContent extends StatefulWidget {

  /// Constructor for the SensitiveContent widget.
  ///
  /// [key] is a key for widget identification and state restoration.
  /// [child] is the widget containing sensitive data.
  /// [publicContent] is the widget containing public content.
  /// [lazy] is a flag to enable lazy loading.
  const SensitiveContent({
    super.key,
    required this.child,
    required this.publicContent,
    this.lazy = true,
  });

  /// the widget containing sensitive data.
  final Widget child;

  /// the widget containing public content.
  final Widget publicContent;

  /// lazy loading prevent destroy widget data when rebuild
  final bool lazy;

  @override
  State createState() => _SensitiveContentState();
}

class _SensitiveContentState extends State<SensitiveContent> {
  late final AppLifecycleListener _listener;

  /// ValueNotifier to determine if the application is in the foreground.
  final ValueNotifier<bool> _isInForeground = ValueNotifier(true);

  void _handleTransition(String name) {
    debugPrint("[AppLifecycleState] $name");
  }

  void _handleStateChange(AppLifecycleState state) {
    _isInForeground.value = (state == AppLifecycleState.resumed);
  }

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onShow: () => _handleTransition('show'),
      onResume: () => _handleTransition('resume'),
      onHide: () => _handleTransition('hide'),
      onInactive: () => _handleTransition('inactive'),
      onPause: () => _handleTransition('pause'),
      onDetach: () => _handleTransition('detach'),
      onRestart: () => _handleTransition('restart'),
      // This fires for each state change. Callbacks above fire only for
      // specific state transitions.
      onStateChange: _handleStateChange,
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _isInForeground,
        builder: (context, isInForeground, child) {
          return (widget.lazy)
              ? LazyIndexedStack(
                  index: isInForeground ? 0 : 1,
                  children: [widget.child, widget.publicContent],
                )
              : Container(
                  child: (isInForeground) ? widget.child : widget.publicContent,
                );
        });
  }
}

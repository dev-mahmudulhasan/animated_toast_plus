library animated_toast_plus;

import 'package:flutter/material.dart';

enum ToastPosition { top, bottom, center }

class AnimatedToastPlus {
  /// Show success toast
  static void showSuccess(
    BuildContext context, {
    required String title,
    String? subtitle,
    Widget? iconWidget,
    ToastPosition position = ToastPosition.top,
    Duration duration = const Duration(seconds: 2),
    Color? backgroundColor,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      icon: Icons.check_circle,
      iconWidget: iconWidget,
      backgroundColor: backgroundColor ?? Colors.green.shade700,
      position: position,
      duration: duration,
    );
  }

  /// Show error toast
  static void showError(
    BuildContext context, {
    required String title,
    String? subtitle,
    Widget? iconWidget,
    ToastPosition position = ToastPosition.top,
    Duration duration = const Duration(seconds: 2),
    Color? backgroundColor,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      icon: Icons.error,
      iconWidget: iconWidget,
      backgroundColor: backgroundColor ?? Colors.red.shade700,
      position: position,
      duration: duration,
    );
  }

  /// Show warning toast
  static void showWarning(
    BuildContext context, {
    required String title,
    String? subtitle,
    Widget? iconWidget,
    ToastPosition position = ToastPosition.top,
    Duration duration = const Duration(seconds: 2),
    Color? backgroundColor,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      icon: Icons.warning_amber_rounded,
      iconWidget: iconWidget,
      backgroundColor: backgroundColor ?? Colors.orange.shade700,
      position: position,
      duration: duration,
    );
  }

  /// Show info toast
  static void showInfo(
    BuildContext context, {
    required String title,
    String? subtitle,
    Widget? iconWidget,
    ToastPosition position = ToastPosition.top,
    Duration duration = const Duration(seconds: 2),
    Color? backgroundColor,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      icon: Icons.info_outline,
      iconWidget: iconWidget,
      backgroundColor: backgroundColor ?? Colors.blue.shade700,
      position: position,
      duration: duration,
    );
  }

  /// Show custom toast
  static void show(
    BuildContext context, {
    required String title,
    String? subtitle,
    IconData? icon,
    Widget? iconWidget,
    Color backgroundColor = Colors.black87,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    ToastPosition position = ToastPosition.top,
    Duration duration = const Duration(seconds: 2),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        title: title,
        subtitle: subtitle,
        icon: icon,
        iconWidget: iconWidget,
        backgroundColor: backgroundColor,
        titleStyle:
            titleStyle ??
            const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
        subtitleStyle:
            subtitleStyle ??
            const TextStyle(fontSize: 14, color: Colors.white70),
        position: position,
      ),
    );

    overlay?.insert(overlayEntry);

    Future.delayed(duration + const Duration(milliseconds: 300), () {
      overlayEntry.remove();
    });
  }
}

class _ToastWidget extends StatefulWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? iconWidget;
  final Color backgroundColor;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final ToastPosition position;

  const _ToastWidget({
    Key? key,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconWidget,
    required this.backgroundColor,
    required this.titleStyle,
    required this.subtitleStyle,
    required this.position,
  }) : super(key: key);

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  late AnimationController _iconAnimationController;
  late Animation<double> _iconScaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    Offset beginOffset;
    switch (widget.position) {
      case ToastPosition.top:
        beginOffset = const Offset(0, -1);
        break;
      case ToastPosition.bottom:
        beginOffset = const Offset(0, 1);
        break;
      case ToastPosition.center:
      default:
        beginOffset = Offset.zero;
        break;
    }

    _offsetAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _iconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _iconScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.2,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.2,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_iconAnimationController);

    _iconAnimationController.repeat(reverse: true);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Alignment alignment;
    EdgeInsets padding;

    switch (widget.position) {
      case ToastPosition.top:
        alignment = Alignment.topCenter;
        padding = const EdgeInsets.only(top: 40);
        break;
      case ToastPosition.bottom:
        alignment = Alignment.bottomCenter;
        padding = const EdgeInsets.only(bottom: 40);
        break;
      case ToastPosition.center:
      default:
        alignment = Alignment.center;
        padding = EdgeInsets.zero;
        break;
    }

    return Positioned.fill(
      child: IgnorePointer(
        child: SafeArea(
          child: Padding(
            padding: padding,
            child: Align(
              alignment: alignment,
              child: SlideTransition(
                position: _offsetAnimation,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                    minWidth: 280,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: widget.backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.center, // changed from start
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (widget.iconWidget != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 12,
                              ), // removed top padding
                              child: ScaleTransition(
                                scale: _iconScaleAnimation,
                                child: SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: widget.iconWidget,
                                ),
                              ),
                            )
                          else if (widget.icon != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 12,
                              ), // removed top padding
                              child: ScaleTransition(
                                scale: _iconScaleAnimation,
                                child: Icon(
                                  widget.icon,
                                  size: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(widget.title, style: widget.titleStyle),
                                if (widget.subtitle != null) ...[
                                  const SizedBox(height: 6),
                                  Text(
                                    widget.subtitle!,
                                    style: widget.subtitleStyle,
                                  ),
                                ],
                              ],
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
        ),
      ),
    );
  }
}

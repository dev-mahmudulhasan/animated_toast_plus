import 'package:flutter/material.dart';
import 'package:animated_toast_plus/animated_toast_plus.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Toast Plus Demo',
      home: const ToastDemo(),
    );
  }
}

class ToastDemo extends StatelessWidget {
  const ToastDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toast Example')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _toastButton(
              context,
              label: 'Success Toast',
              onPressed: () => AnimatedToastPlus.showSuccess(
                context,
                title: 'Success!',
                subtitle: 'Everything is working perfectly.',
              ),
            ),
            _toastButton(
              context,
              label: 'Error Toast',
              onPressed: () => AnimatedToastPlus.showError(
                context,
                title: 'Error!',
                subtitle: 'Something went wrong.',
              ),
            ),
            _toastButton(
              context,
              label: 'Warning Toast',
              onPressed: () => AnimatedToastPlus.showWarning(
                context,
                title: 'Warning!',
                subtitle: 'Be careful with this step.',
              ),
            ),
            _toastButton(
              context,
              label: 'Info Toast',
              onPressed: () => AnimatedToastPlus.showInfo(
                context,
                title: 'Info',
                subtitle: 'Here’s something useful.',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toastButton(
    BuildContext context, {
    required String label,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(onPressed: onPressed, child: Text(label)),
    );
  }
}

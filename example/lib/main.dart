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
            const Text(
              'Try different animated toast types',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            _toastButton(
              context,

              label: '✅ Success Toast',
              color: Colors.green,
              onPressed: () => AnimatedToastPlus.showSuccess(
                context,
                position: ToastPosition.top,
                title: 'Success!',
                subtitle: 'Everything is working perfectly.',
              ),
            ),
            _toastButton(
              context,
              label: '❌ Error Toast',
              color: Colors.red,
              onPressed: () => AnimatedToastPlus.showError(
                context,
                position: ToastPosition.bottom,
                title: 'Error!',
                subtitle: 'Something went wrong.',
              ),
            ),
            _toastButton(
              context,
              label: '⚠️ Warning Toast',
              color: Colors.orange,
              onPressed: () => AnimatedToastPlus.showWarning(
                context,
                position: ToastPosition.center,
                title: 'Warning!',
                subtitle: 'Be careful with this step.',
              ),
            ),
            _toastButton(
              context,
              label: 'ℹ️ Info Toast',
              color: Colors.blue,
              onPressed: () => AnimatedToastPlus.showInfo(
                context,
                title: 'Info',
                subtitle: 'Here’s something useful.',
              ),
            ),
            _toastButton(
              context,
              label: '🎉 Custom Toast',
              color: Colors.teal,
              onPressed: () => AnimatedToastPlus.show(
                context,
                title: 'Custom',
                subtitle: 'You have 3 new notifications.',
                iconWidget: Image.network(
                  'https://cdn.pixabay.com/photo/2024/05/26/10/15/bird-8788491_1280.jpg',
                  height: 28,
                  width: 28,
                  fit: BoxFit.cover,
                ),
                backgroundColor: Colors.teal,
                position: ToastPosition.center,
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
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontSize: 16),
          ),
          child: Text(label),
        ),
      ),
    );
  }
}

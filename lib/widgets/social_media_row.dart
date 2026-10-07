import 'package:flutter/material.dart';

class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({super.key});

  void _showSnack(BuildContext context, String name) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$name diklik'),
          duration: const Duration(seconds: 1),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          tooltip: 'Instagram',
          icon: const Icon(Icons.camera_alt, color: Colors.pink),
          onPressed: () => _showSnack(context, 'Instagram'),
        ),
        IconButton(
          tooltip: 'LinkedIn',
          icon: const Icon(Icons.work, color: Colors.blue),
          onPressed: () => _showSnack(context, 'LinkedIn'),
        ),
        IconButton(
          tooltip: 'GitHub',
          icon: const Icon(Icons.code, color: Colors.black87),
          onPressed: () => _showSnack(context, 'GitHub'),
        ),
      ],
    );
  }
}

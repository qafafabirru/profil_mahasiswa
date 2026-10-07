import 'package:flutter/material.dart';

import 'profile_photo.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String nim;
  final String? imageUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.nim,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePhoto(imageUrl: imageUrl, radius: 60),
        const SizedBox(height: 24),
        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'NIM: $nim',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}

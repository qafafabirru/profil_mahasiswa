import 'package:flutter/material.dart';

import '../widgets/profile_header.dart';
import '../widgets/profile_info.dart';
import '../widgets/social_media_row.dart';
import '../widgets/action_buttons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    SizedBox(height: 24),
                    ProfileHeader(
                      name: 'Quhadja Afafa Birru Auliya',
                      nim: '25.11.6301',
                    ),
                    SizedBox(height: 24),
                    ProfileInfo(
                      programStudi: 'S1 Informatika',
                      email: 'q.afafa@students.amikom.ac.id',
                      lokasi: 'Yogyakarta, Indonesia',
                    ),
                    SizedBox(height: 16),
                    SocialMediaRow(),
                  ],
                ),
              ),
            ),
            const ActionButtons(),
          ],
        ),
      ),
    );
  }
}

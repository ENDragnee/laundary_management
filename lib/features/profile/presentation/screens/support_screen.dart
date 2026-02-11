import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  // Helper to launch URLs
  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Support & Upgrade')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Upgrade Instructions Card
          Card(
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.upgrade, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        'How to Upgrade',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'To unlock unlimited orders, editing, and deleting, follow these steps:\n\n'
                    '1. Contact the developer via Telegram or Phone.\n'
                    '2. Pay the one-time Registration Fee.\n'
                    '3. Send a screenshot or evidence of payment.\n'
                    '4. Your account will be activated within minutes.',
                    style: TextStyle(height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          Text('Contact Developer', style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),

          _ContactTile(
            icon: Icons.telegram,
            label: 'Telegram',
            value: '@Redglance',
            onTap: () => _launch('https://t.me/Redglance'),
          ),
          _ContactTile(
            icon: Icons.phone_android,
            label: 'Phone',
            value: '+251 915 949 551',
            onTap: () => _launch('tel:+251915949551'),
          ),
          _ContactTile(
            icon: Icons.email_outlined,
            label: 'Email',
            value: 'mesfinmastwal@gmail.com',
            onTap: () => _launch('mailto:mesfinmastwal@gmail.com'),
          ),
          _ContactTile(
            icon: Icons.language,
            label: 'Portfolio',
            value: 'mastwal-mesfin.vercel.app',
            onTap: () => _launch('https://mastwal-mesfin.vercel.app/'),
          ),

          const SizedBox(height: 40),
          Center(
            child: Column(
              children: [
                Text(
                  'Laundry Management App',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  'Version 1.0.0',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _ContactTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
      trailing: const Icon(Icons.open_in_new, size: 16),
      onTap: onTap,
    );
  }
}

import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundary_management/core/database/app_database.dart';
import 'package:powersync/powersync.dart' as ps; // Import PowerSync
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final user = Supabase.instance.client.auth.currentUser;
    final database = context.read<AppDatabase>();

    try {
      final updateStatement = database.update(database.laundries)
        ..where((t) => t.id.equals(user!.id));

      await updateStatement.write(
        LaundriesCompanion(
          name: d.Value(_nameController.text.trim()),
          phoneNumber: d.Value(_phoneController.text.trim()),
          updatedAt: d.Value(DateTime.now().toIso8601String()),
        ),
      );
      if (mounted) context.go('/dashboard');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final powersync = context.read<ps.PowerSyncDatabase>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Setup Laundry Profile')),
      body: StreamBuilder<ps.SyncStatus>(
        stream: powersync.statusStream,
        builder: (context, snapshot) {
          final status = snapshot.data;
          // If PowerSync is actively downloading the first time, show a major loader
          final bool isSyncingFirstTime =
              status?.connected == true && (status?.downloading ?? false);

          if (isSyncingFirstTime) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 24),
                  Text(
                    'Checking for existing profile...',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This happens once during setup',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Welcome! Please set up your laundry shop details.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Laundry Shop Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _saveProfile,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Start Using App'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
